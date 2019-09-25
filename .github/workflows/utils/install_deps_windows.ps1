# Powershell script

iex (new-object net.webclient).downloadstring('https://get.scoop.sh')
scoop install ninja
scoop install llvm

.\.github\workflows\utils\vs_setup.bat -arch=amd64

# Remove link.exe from git-bash, as it conflicts with msvc link.exe...
del c:\PROGRA~1\Git\usr\bin\link.exe

echo "::set-env name=CC::clang-cl"
echo "::set-env name=CXX::clang-cl"
