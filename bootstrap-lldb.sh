#!/usr/bin/env bash

LLDBINIT=$HOME/.lldbinit
DWARFDUMP_BIN=$(find /usr/bin -name "*llvm-dwarfdump*")
RUBY_SRC_PATH=$(find /tmp -type d -name "ruby-build.*.*")
RUBY_SRC_MAP_PATH=$($DWARFDUMP_BIN /opt/ruby/bin/ruby | head | grep DW_AT_comp_dir | uniq | cut -d\" -f 2)

echo "settings set target.source-map $RUBY_SRC_MAP_PATH $RUBY_SRC_PATH" > $LLDBINIT
echo "command script import -r $RUBY_SRC_PATH/misc/lldb_cruby.py" >> $LLDBINIT
echo "type format add --format hex VALUE" >> $LLDBINIT
