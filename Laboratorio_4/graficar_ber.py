from asyncio.windows_events import NULL

import numpy as np
import matplotlib.pyplot as plt
from scipy.special import erfc

import math

# ─────────────────────────────────────────────
# VALORES MEDIDOS (log10(BER))
# ─────────────────────────────────────────────

ebn0_dB = np.arange(1, 12)

log_ber_BPSK = [-2.8058, -3.1429,  -3.5461, -4.0230, -4.6981, -5.3604, -6.2084]
log_ber_QPSK = [-3.1188, -3.34247, -3.5750, -3.9150, -4.4476, -5.1905, -5.6777]  # reemplaza con tus valores
log_ber_8PSK = [-0.9662, -1.0086, -1.0477 , -1.1180, -1.3318,  -1.5408, -1.6607,  -1.7909, -1.9001, -2.1123, -2.3456 ] #con tus valores

# ─────────────────────────────────────────────
# CURVAS TEÓRICAS
# ─────────────────────────────────────────────

ebn0_lin = 10 ** (ebn0_dB / 10)

ber_teo_BPSK = 0.5 * erfc(np.sqrt(ebn0_lin))
ber_teo_QPSK = 0.5 * erfc(np.sqrt(ebn0_lin))
ber_teo_8PSK = (1/3) * erfc(np.sqrt(3 * ebn0_lin) * np.sin(np.pi / 8))

# ─────────────────────────────────────────────
# CONVERTIR VALORES MEDIDOS
# ─────────────────────────────────────────────

def convertir(log_valores):
    x, y = [], []
    for i, v in enumerate(log_valores):
        if v is not None:
            x.append(ebn0_dB[i])
            y.append(10 ** v)
    return np.array(x), np.array(y)

x_BPSK, y_BPSK = convertir(log_ber_BPSK)
x_QPSK, y_QPSK = convertir(log_ber_QPSK)
x_8PSK, y_8PSK = convertir(log_ber_8PSK)


todos_sim = [10**v for vals in [log_ber_BPSK, log_ber_QPSK, log_ber_8PSK]
             for v in vals if v is not None]
todos_teo = list(ber_teo_BPSK) + list(ber_teo_QPSK) + list(ber_teo_8PSK)

ymin = min(todos_teo + todos_sim)
ymax = max(todos_teo + todos_sim)


ymin_plot = 10 ** math.floor(math.log10(ymin))
ymax_plot = 10 ** math.ceil(math.log10(ymax))


fig, ax = plt.subplots(figsize=(9, 6))

ax.semilogy(ebn0_dB, ber_teo_BPSK, 'b-',  linewidth=1.5, label='BPSK Teórico')
ax.semilogy(ebn0_dB, ber_teo_QPSK, 'g-',  linewidth=1.5, label='QPSK Teórico')
ax.semilogy(ebn0_dB, ber_teo_8PSK, 'r-',  linewidth=1.5, label='8PSK Teórico')

if len(x_BPSK) > 0:
    ax.semilogy(x_BPSK, y_BPSK, 'bo--', markersize=6, label='BPSK Simulado')
if len(x_QPSK) > 0:
    ax.semilogy(x_QPSK, y_QPSK, 'gs--', markersize=6, label='QPSK Simulado')
if len(x_8PSK) > 0:
    ax.semilogy(x_8PSK, y_8PSK, 'r^--', markersize=6, label='8PSK Simulado')

ax.set_xlabel("Eb/N0 (dB)", fontsize=12)
ax.set_ylabel("BER", fontsize=12)
ax.set_title("BER vs Eb/N0 — BPSK, QPSK y 8PSK", fontsize=13)
ax.set_xlim(1, 11)
ax.set_ylim(ymin_plot, ymax_plot)
ax.grid(True, which="both", linestyle="--", alpha=0.6)
ax.legend(fontsize=10)

plt.tight_layout()
plt.savefig("BER_curvas.png", dpi=150)
plt.show()
print("Gráfica guardada como BER_curvas.png")