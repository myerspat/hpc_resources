# Specs of AIMS Clusters

## AIMS01

- OS: Ubuntu 22.04 with Lambda Stack for managing TensorFlow, PyTorch, CUDA, cuDNN, etc.
- Processor: AMD Ryzen Threadripper PRO 5955WX
	- 16 cores/32 threads (4.0-4.5 GHz), 64 MB cache, PCIe 4.0
- GPU: 2x NVIDIA GeForce RTX 4090
	- 24 GB memory, 16384 CUDA cores, 512 Tensor cores, liquid cooling
- Memory: 512 GB DDR4-3200 ECC RDIMM
- OS Drive: 3.84 TB M.2 NVMe
- Data Drive: 2x 3.84 TB SATA: Data center SSD, 1 DWPD

## AIMS02

- OS: Ubuntu 22.04 with Lambda Stack for managing TensorFlow, PyTorch, CUDA, cuDNN, etc.
- Processor: 2x AMD EPYC 9654 
	- 96 cores (2.4-3.7 GHz), 384 MB cache, PCIe 5.0
        - Total: 192 cores (384 threads)
- GPU: 4x NVIDIA RTX 6000 Ada Generation
- Memory: 1536 GB DDR5-4800 RDIMM
- OS Drive: 3.84 TB Samsung PM9A3 NVMe Gen4 M.2 SSD
- Data Drive: 2x 15.36 TB Samsung PM9A3 NVMe Gen4 M.2 SSD
