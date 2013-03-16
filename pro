#!/bin/sh

echo "Enter map output path:"
read output
echo "Attempting to build $output..."

if [ -f "$output" ]; then
  echo "Removing old ($output) files"
  rm "$output"*
fi

./map/build env:pro do_compile:"Hash[\'pregenerated\'=>false, 'owner'=>'quazz', 'generate'=>false]" map_output_path:"../$output"