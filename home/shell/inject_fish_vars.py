import tempfile
import shutil
import os
import sys

# A script to inject non-volatile fish variables into the fish_variables file, if changes are required.
# Fish tends to store both volatile and non-volatile variables in the same file, which makes it difficult to
# track changes in version control. This script will merge the non-volatile variables from the reference file
# into the real file if any changes are required, and leave the volatile variables alone.

def parse_fish_variables(path):
    variables = []
    with open(path, 'r') as file:
        for line in file:
            if line.startswith('SETUVAR'):
                parts = line.strip().split(':', 1)
                if len(parts) == 2:
                    key, value = parts
                    key = key[8:]
                    variables.append((key, value))
    return variables

def merge_variables(ref_path, real_path):
    # If real path doesn't exist, just copy the file directly
    if not os.path.exists(real_path):
        print("fish_varaiables: No existing fish_variables file found, copying")
        shutil.copy(ref_path, real_path)
        return

    ref_vars = parse_fish_variables(ref_path)
    real_vars = parse_fish_variables(real_path)

    # Filter out volatile variables (those starting with '_')
    non_volatile_ref_vars = [var for var in ref_vars if not var[0].startswith('_')]
    non_volatile_real_vars = [var for var in real_vars if not var[0].startswith('_')]
    volatile_real_vars = [var for var in real_vars if var[0].startswith('_')]

    # Compare and merge
    if len(ref_vars) == len(real_vars) and all(r == v for r, v in zip(non_volatile_ref_vars, non_volatile_real_vars)):
        print("fish_varaiables: No changes required.")
    else:
        print("fish_varaiables: Changes required, altering")

        merged_vars = volatile_real_vars + non_volatile_ref_vars

        # Build the new fish_variables content
        new_content = "# This file contains fish universal variable definitions.\n# VERSION: 3.0\n"
        for key, value in merged_vars:
            new_content += f"SETUVAR {key}:{value}\n"

        # Write to a temporary file
        with tempfile.NamedTemporaryFile(delete=False) as temp_file:
            temp_file.write(new_content.encode())
            temp_file_path = temp_file.name

        # Safely replace the real fish_variables file
        shutil.copy(temp_file_path, real_path)
        os.remove(temp_file_path)

# Invoke the script from the args
ref_file_path = sys.argv[1]
real_file_path = sys.argv[2]
merge_variables(ref_file_path, real_file_path)