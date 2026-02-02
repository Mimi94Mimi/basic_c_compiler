# 先更新軟體源清單，確保抓到最新版本
sudo apt update

# 安裝 flex 本體
sudo apt install flex

sudo apt install byacc

sudo apt install build-essential

wget https://github.com/riscv-collab/riscv-gnu-toolchain/releases/download/2026.01.23/riscv32-elf-ubuntu-24.04-gcc.tar.xz

tar -Jxvf riscv32-elf-ubuntu-24.04-gcc.tar.xz

export PATH="$PATH:/root/basic_c_compiler/riscv/bin"

source ~/.bashrc