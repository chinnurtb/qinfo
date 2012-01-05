/// @file   precomp.h
/// @author Dmitry S. Melnikov, dmitryme@cqg.com
/// @date   Created on: 01/04/2012 04:25:04 PM

#ifndef MICEX_DRIVER_PRECOMP_H
#define MICEX_DRIVER_PRECOMP_H

#define _WIN32_WINNT 0x0501

#include <ei_cxx/log_wrapper.h>

#include <boost/cstdint.hpp>

#define NOMINMAX

#include <Windows.h>

namespace
{

int const MTE_ERRMSG_SIZE = 256 + 1;
int const MTE_CONNPARAMS_SIZE = 2048 + 1;


std::string get_string(char const*& buff)
{
   boost::int32_t sz = *(boost::int32_t*)buff;
   std::string res(buff + sizeof(boost::int32_t), sz);
   buff += (sz + sizeof(boost::int32_t));
   return res;
}

boost::int32_t get_int32(char const*& buff)
{
   boost::int32_t res *(boost::int32_t*)buff;
   buff += sizeof(boost::int32);
   return res;
}

} // namespace


#endif // MICEX_DRIVER_PRECOMP_H
