/// @file   table.h
/// @author Dmitry S. Melnikov, dmitryme@cqg.com
/// @date   Created on: 01/04/2012 08:35:49 AM

#ifndef MICEX_DRIVER_TABLE_H
#define MICEX_DRIVER_TABLE_H

#include "field.h"

#include <boost/shared_ptr.hpp>

#include <string>

namespace micex
{

class Table
{
public:
   Table(std::string const& name, bool completeLoad, bool refreshEnabled);
   std::string const& name() const { return m_name; }
   void init(char const* buff);
   static void skip(char const*& buff);
private:
   std::string const m_name;
   bool const m_completeLoad;
   bool const m_refreshEnabled;
   long       m_ref;
   static long m_cookie;
};

typedef boost::shared_ptr<Table> TablePtr;

} // namespace


#endif // MICEX_DRIVER_TABLE_H
