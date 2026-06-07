import numpy as np

# Leer archivo binario como float32
data = np.fromfile("D:\Comunicaciones_Digitales_Labs\Laboratorio_4\BER_QPSK.csv", dtype=np.float32)

# Guardar en CSV legible
np.savetxt("BER_QPSK_legible.csv", data, delimiter=",")
