#!/bin/bash

# On your terminal, input all the commands you have used to create the following:
workdir="$(mktemp -d "${TMPDIR:-/tmp}/bash-assignment-XXXXXX")"
pushd "$workdir" >/dev/null
# 1. How would you create 5 directories? Feel free to use any name for your directories.
dirs=(dir{1..5})
mkdir -p "${dirs[@]}"

# 2. How would you verify the creation of all 5 directories?
missing=0
for d in "${dirs[@]}"; do
  [[ -d "$d" ]] || { echo "Missing: $d"; missing=1; }
done
(( missing == 0 )) && echo "All 5 directories created successfully."

# 3. In each directory, how would you create 5 .txt files and write "I love data" into each within the directories?
for d in "${dirs[@]}"; do
  for i in {1..5}; do
    printf 'I love data' > "$d/file$i.txt"
  done
done
# 4. How would you verify the presence of all 5 files?
count=$(find "${dirs[@]}" -type f -name '*.txt' | wc -l)
echo "Found $count .txt files."
(( count == 25 )) || echo "Expected 25 files."

# 5. How would you append to one of the existing files " and machine learning!"?
echo " and machine learning!" >> dir1/file1.txt

# 6. How would you verify that the text was indeed appended to the existing file?
if grep -q '^I love data and machine learning!$' "dir1/file1.txt"; then
  echo "Text is appended."
else
  echo "Text not appended as expected in dir1/file1.txt"
fi

# 7. How would you delete all files except for the one with the appended text?
find . -name "*.txt" ! -path "$(pwd)/dir1/file1.txt" -delete


# 8. How would you navigate back to the parent directory containing all the directories?
popd >/dev/null

# 9. How would you remove each directory along with its contents?
rm -rf -- "$workdir"

# 10. How would you verify that all directories and files have been deleted?
if [[ ! -d "$workdir" ]]; then
  echo "All directories and files have been deleted."
else
  echo "Cleanup failed: $workdir still exists."
fi