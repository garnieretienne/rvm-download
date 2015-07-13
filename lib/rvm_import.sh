#!/bin/bash
#
# Functions imported from RVM source code and local aliases

# RVM function to detect the current system
# Src: https://github.com/wayneeseguin/rvm/blob/98c0a3aadfcade0b9b34701978c4eacfbcc17eba/scripts/functions/utility_system#L3
__rvm_detect_system()
{
  unset _system_type _system_name _system_version _system_arch
  export _system_type _system_name _system_version _system_arch
  _system_info="$(command uname -a)"
  _system_type="unknown"
  _system_name="unknown"
  _system_name_lowercase="unknown"
  _system_version="unknown"
  _system_arch="$(command uname -m)"
  case "$(command uname)" in
    (Linux|GNU*)
      _system_type="Linux"
      if
        [[ -f /etc/lsb-release ]] &&
        GREP_OPTIONS="" \grep "DISTRIB_ID=Ubuntu" /etc/lsb-release >/dev/null
      then
        _system_name="Ubuntu"
        _system_version="$(awk -F'=' '$1=="DISTRIB_RELEASE"{print $2}' /etc/lsb-release)"
        _system_arch="$( dpkg --print-architecture )"
      elif
        [[ -f /etc/lsb-release ]] &&
        GREP_OPTIONS="" \grep "DISTRIB_ID=LinuxMint" /etc/lsb-release >/dev/null
      then
        _system_name="Mint"
        _system_version="$(awk -F'=' '$1=="DISTRIB_RELEASE"{print $2}' /etc/lsb-release)"
        _system_arch="$( dpkg --print-architecture )"
      elif
        [[ -f /etc/lsb-release ]] &&
        GREP_OPTIONS="" \grep "DISTRIB_ID=ManjaroLinux" /etc/lsb-release >/dev/null
      then
        _system_name="Manjaro"
        _system_version="$(awk -F'=' '$1=="DISTRIB_RELEASE"{print $2}' /etc/lsb-release)"
      elif
        [[ -f /etc/altlinux-release ]]
      then
        _system_name="Arch"
        _system_version="libc-$(ldd --version | \awk 'NR==1 {print $NF}' | \awk -F. '{print $1"."$2}')"
      elif
        [[ -f /etc/os-release ]] &&
        GREP_OPTIONS="" \grep "ID=opensuse" /etc/os-release >/dev/null
      then
        _system_name="OpenSuSE"
        _system_version="$(awk -F'=' '$1=="VERSION_ID"{gsub(/"/,"");print $2}' /etc/os-release)" #'
      elif
        [[ -f /etc/SuSE-release ]]
      then
        _system_name="SuSE"
        _system_version="$(
          \awk -F'=' '{gsub(/ /,"")} $1~/VERSION/ {version=$2} $1~/PATCHLEVEL/ {patch=$2} END {print version"."patch}' < /etc/SuSE-release
        )"
      elif
        [[ -f /etc/debian_version ]]
      then
        _system_name="Debian"
        _system_version="$(\cat /etc/debian_version | \awk -F. '{print $1}')"
        _system_arch="$( dpkg --print-architecture )"
      elif
        [[ -f /etc/os-release ]] &&
        GREP_OPTIONS="" \grep "ID=debian" /etc/os-release >/dev/null
      then
        _system_name="Debian"
        _system_version="$(awk -F'=' '$1=="VERSION_ID"{gsub(/"/,"");print $2}' /etc/os-release | \awk -F. '{print $1}')" #'
        _system_arch="$( dpkg --print-architecture )"
      elif
        [[ -f /etc/system-release ]] &&
        GREP_OPTIONS="" \grep "Amazon Linux AMI" /etc/system-release >/dev/null
      then
        _system_name="Amazon"
        _system_version="$(GREP_OPTIONS="" \grep -Eo '[0-9\.]+' /etc/system-release | \awk -F. '{print $1"."$2}')"
      elif
        [[ -f /etc/sabayon-release ]]
      then
        # needs to be before gentoo
        _system_name="Sabayon"
        _system_version="$(\cat /etc/sabayon-release | \awk 'NR==1 {print $NF}' | \awk -F. '{print $1"."$2}')"
      elif
        [[ -f /etc/gentoo-release ]]
      then
        _system_name="Gentoo"
        _system_version="base-$(\cat /etc/gentoo-release | \awk 'NR==1 {print $NF}' | \awk -F. '{print $1"."$2}')"
      elif
        [[ -f /etc/arch-release ]]
      then
        _system_name="Arch"
        _system_version="libc-$(ldd --version | \awk 'NR==1 {print $NF}' | \awk -F. '{print $1"."$2}')"
      elif
        [[ -f /proc/devices ]] &&
        GREP_OPTIONS="" \grep -Eo "synobios" /proc/devices >/dev/null
      then
        _system_type="BSD"
        _system_name="Synology"
        _system_version="libc-$(ldd --version | \awk 'NR==1 {print $NF}' | \awk -F. '{print $1"."$2}')"
      elif
        [[ -f /etc/fedora-release ]]
      then
        _system_name="Fedora"
        _system_version="$(GREP_OPTIONS="" \grep -Eo '[0-9]+' /etc/fedora-release)"
      elif
        [[ -f /etc/centos-release ]]
      then
        _system_name="CentOS"
        _system_version="$(GREP_OPTIONS="" \grep -Eo '[0-9\.]+' /etc/centos-release | \awk -F. '{print $1}')"
      elif
        [[ -f /etc/redhat-release ]]
      then
        _system_name="$(
          GREP_OPTIONS="" \grep -Eo 'CentOS|ClearOS|Mageia|Scientific' /etc/redhat-release 2>/dev/null
        )" ||
        _system_name="CentOS"
        _system_version="$(GREP_OPTIONS="" \grep -Eo '[0-9\.]+' /etc/redhat-release | \awk -F. 'NR==1{print $1}')"
      else
        _system_version="libc-$(ldd --version | \awk 'NR==1 {print $NF}' | \awk -F. '{print $1"."$2}')"
      fi
      ;;
    (SunOS)
      _system_type="SunOS"
      _system_name="Solaris"
      _system_version="$(command uname -v)"
      _system_arch="$(command uname -p)"
      if
        [[ "${_system_version}" =~ ^joyent* ]]
      then
        _system_name="SmartOS"
        _system_version="${_system_version#* }"
      elif
        [[ "${_system_version}" =~ ^omnios* ]]
      then
        _system_name="OmniOS"
        _system_version="${_system_version#* }"
      elif
        [[ "${_system_version}" =~ ^oi* || "${_system_version}" =~ ^illumos* ]]
      then
        _system_name="OpenIndiana"
        _system_version="${_system_version#* }"
      elif
        [[ "${_system_version}" =~ Generic* ]]
      then
        _system_version="10"
      elif
        [[ "${_system_version}" =~ 11* ]]
      then
        _system_version="11"
      # is else needed here?
      fi
      ;;
    (FreeBSD)
      _system_type="BSD"
      _system_name="FreeBSD"
      _system_version="$(command uname -r)"
      _system_version="${_system_version%%-*}"
      ;;
    (OpenBSD)
      _system_type="BSD"
      _system_name="OpenBSD"
      _system_version="$(command uname -r)"
      ;;
    (DragonFly)
      _system_type="BSD"
      _system_name="DragonFly"
      _system_version="$(command uname -r)"
      _system_version="${_system_version%%-*}"
      ;;
    (NetBSD)
      _system_type="BSD"
      _system_name="NetBSD"
      _system_version_full="$(command uname -r)"
      _system_version="$(echo ${_system_version_full} | \awk -F. '{print $1"."$2}')"
      ;;
    (Darwin)
      _system_type="Darwin"
      _system_name="OSX"
      _system_version="$(sw_vers -productVersion | \awk -F. '{print $1"."$2}')"
      ;;
    (CYGWIN*)
      _system_type="Windows"
      _system_name="Cygwin"
      ;;
    (MINGW*)
      _system_type="Windows"
      _system_name="Mingw"
      ;;
    (*)
      return 1
      ;;
  esac
  _system_type="${_system_type//[ \/]/_}"
  _system_name="${_system_name//[ \/]/_}"
  _system_name_lowercase="$(echo ${_system_name} | \tr '[A-Z]' '[a-z]')"
  _system_version="${_system_version//[ \/]/_}"
  _system_arch="${_system_arch//[ \/]/_}"
  _system_arch="${_system_arch/amd64/x86_64}"
  _system_arch="${_system_arch/i[123456789]86/i386}"
}

# Export the result of `__rvm_detect_system` function into constants
detect_system() {
  __rvm_detect_system
  SYSTEM_NAME=${SYSTEM_NAME:-"$_system_name"}
  SYSTEM_TYPE=${SYSTEM_TYPE:-"$_system_type"}
  SYSTEM_VERSION=${SYSTEM_VERSION:-"$_system_version"}
  SYSTEM_ARCH=${SYSTEM_ARCH:-"$_system_arch"}
}
