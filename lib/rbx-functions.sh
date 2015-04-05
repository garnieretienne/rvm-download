#!/bin/bash
#
# Utility functions for Rubinius
# from https://github.com/sstephenson/ruby-build

fix_rbx_gem_binstubs() {
  local prefix="$1"
  local gemdir="${prefix}/gems/bin"
  local bindir="${prefix}/bin"
  local file binstub
  # Symlink Rubinius' `gems/bin/` into `bin/`
  if [ -d "$gemdir" ] && [ ! -L "$gemdir" ]; then
    for file in "$gemdir"/*; do
      binstub="${bindir}/${file##*/}"
      rm -f "$binstub"
      { echo "#!${bindir}/ruby"
        grep -v '^#!' "$file"
      } > "$binstub"
      chmod +x "$binstub"
    done
    rm -rf "$gemdir"
    ln -s ../bin "$gemdir"
  fi
}

fix_rbx_irb() {
  local prefix="$1"
  "${prefix}/bin/irb" --version &>/dev/null ||
    "${prefix}/bin/gem" install rubysl-tracer -v '~> 2.0' --no-rdoc --no-ri &>/dev/null ||
    true
}

