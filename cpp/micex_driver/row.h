/// @file   row.h
/// @author Dmitry S. Melnikov, dmitryme@cqg.com
/// @date   Created on: 01/10/2012 10:36:13 PM

#ifndef MICEX_DRIVER_ROW_H
#define MICEX_DRIVER_ROW_H

#include "precomp.h"
#include "field.h"

#include <list>
#include <map>
#include <string>

namespace micex
{

class Row
{
   friend class Table;
public:
   Row();
   OutFieldPtr getField(std::string const& fieldName) const;
   OutFieldPtr first() const;
   OutFieldPtr next() const;
   size_t size() const { return m_fields.size(); }
private:
   void addField(OutFieldPtr outField);
   void reset();
private:
   typedef std::list<OutFieldPtr> OutFields;
   typedef std::map<std::string, OutFieldPtr> Index;
   OutFields m_fields;
   Index     m_index;
   mutable OutFields::const_iterator m_cursor;
};

} // namespace micex

#endif // MICEX_DRIVER_ROW_H
