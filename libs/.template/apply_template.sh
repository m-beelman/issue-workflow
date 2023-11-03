# This script should crate a project folder in the libs directory.
# It should also copy the template files into the project folder.
# It should also change the project name in the CMakeLists.txt file.
# The project name in the CMakeLists.txt can be replaced with the help of the pattern $PROJECT_NAME_REPLACE$ withi the file. (search and replace)

# Check if the project name is given
if [ $# -eq 0 ]
  then
    echo "No arguments supplied"
    exit 1
fi

# Check if the project name is valid
if [[ ! $1 =~ ^[a-zA-Z0-9_]+$ ]]
  then
    echo "Invalid project name"
    exit 1
fi

# Check if the project already exists
if [ -d "libs/$1" ]
  then
    echo "Project already exists"
    exit 1
fi

# Create the project folder
mkdir libs/$1

# Copy the template files into the project folder except the apply_template.sh file
cp -r libs/.template/* libs/$1
rm libs/$1/apply_template.sh


# Replace the project name in the CMakeLists.txt file
sed -i "s/PROJECT_NAME_REPLACE/$1/g" libs/$1/CMakeLists.txt

# add the project to the top level CMakeLists.txt (add_subdirectory)
echo "add_subdirectory(libs/$1)" >> CMakeLists.txt

