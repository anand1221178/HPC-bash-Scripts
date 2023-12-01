# Install Qiskit Aer from source
echo "Installing Qiskit Aer from source..."
git clone https://github.com/Qiskit/qiskit-aer.git
cd qiskit-aer
pip install -e .

pip install --upgrade pip
#pip install qiskit-terra

curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
source "$HOME/.cargo/env"
rustc --version

# Install Qiskit from source
#git clone https://github.com/Qiskit/qiskit-terra.git
#cd qiskit-terra
#pip install -e .

echo "Installing additional dependencies..."
pip install cython
pip install PyQt5==5.15.4 PyQtWebEngine==5.15.4
pip install spyder==5.4.3
pip install -r requirements-dev.txt

