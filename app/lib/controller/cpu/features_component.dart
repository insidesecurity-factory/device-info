import 'dart:io';
import 'package:flutter/material.dart';
import '../../domain/physical_cpu.dart';

abstract class Strings {
  String get unknown;
  String get cpuFeatures;
  String get search;
  Map<String, String> get cpuFlags;
}

class _EnglishStrings extends Strings {
  @override String get unknown => 'Unknown';
  @override String get cpuFeatures => 'CPU Features';
  @override String get search => 'Search by name';
  @override Map<String, String> get cpuFlags => {
    'FPU': 'Onboard FPU',
    'VME': 'Virtual Mode Extensions',
    'DE': 'Debugging Extensions',
    'PSE': 'Page Size Extensions',
    'TSC': 'Time Stamp Counter',
    'MSR': 'Model-Specific Registers',
    'PAE': 'Physical Address Extensions',
    'MCE': 'Machine Check Exception',
    'CX8': 'CMPXCHG8 instruction',
    'APIC': 'Onboard APIC',
    'SEP': 'SYSENTER/SYSEXIT',
    'MTRR': 'Memory Type Range Registers',
    'PGE': 'Page Global Enable',
    'MCA': 'Machine Check Architecture',
    'CMOV': 'CMOV instructions (plus FCMOVcc, FCOMI with FPU)',
    'PAT': 'Page Attribute Table',
    'PSE36': '36-bit PSEs',
    'PN': 'Processor serial number',
    'CLFLUSH': 'CLFLUSH instruction',
    'DS': '"dts" Debug Store',
    'ACPI': 'ACPI via MSR',
    'MMX': 'Multimedia Extensions',
    'FXSR': 'FXSAVE/FXRSTOR, CR4.OSFXSR',
    'XMM': '"sse"',
    'XMM2': '"sse2"',
    'SELFSNOOP': '"ss" CPU self snoop',
    'HT': 'Hyper-Threading',
    'ACC': '"tm" Automatic clock control',
    'IA64': 'IA-64 processor',
    'PBE': 'Pending Break Enable',

    // AMD-defined CPU features, CPUID level 0x80000001, word 1
    // Don't duplicate feature flags which are redundant with Intel!
    'SYSCALL': 'SYSCALL/SYSRET',
    'MP': 'MP Capable',
    'NX': 'Execute Disable',
    'MMXEXT': 'AMD MMX extensions',
    'FXSR_OPT': 'FXSAVE/FXRSTOR optimizations',
    'GBPAGES': '"pdpe1gb" GB pages',
    'RDTSCP': 'RDTSCP',
    'LM': 'Long Mode (x86-64, 64-bit support)',
    '3DNOWEXT': 'AMD 3DNow extensions',
    '3DNOW': '3DNow',

    // Transmeta-defined CPU features, CPUID level 0x80860001, word 2
    'RECOVERY': 'CPU in recovery mode',
    'LONGRUN': 'Longrun power control',
    'LRTI': 'LongRun table interface',

    // Other features, Linux-defined mapping, word 3
    // This range is used for feature bits which conflict or are synthesized
    'CXMMX': 'Cyrix MMX extensions',
    'K6_MTRR': 'AMD K6 nonstandard MTRRs',
    'CYRIX_ARR': 'Cyrix ARRs (= MTRRs)',
    'CENTAUR_MCR': 'Centaur MCRs (= MTRRs)',

    // CPU types for specific tunings:
    'K8': '"" Opteron, Athlon64',
    // FREE, was #define X86_FEATURE_K7	((3 * 32) + 5) "" Athlon
    'P3': '"" P3',
    'P4': '"" P4',
    'CONSTANT_TSC': 'TSC ticks at a constant rate',
    'UP': 'SMP kernel running on UP',
    'ART': 'Always running timer (ART)',
    'ARCH_PERFMON': 'Intel Architectural PerfMon',
    'PEBS': 'Precise-Event Based Sampling',
    'BTS': 'Branch Trace Store',
    'SYSCALL32': '"" syscall in IA32 userspace',
    'SYSENTER32': '"" sysenter in IA32 userspace',
    'REP_GOOD': 'REP microcode works well',
    // FREE! ((3 * 32) + 17)
    'LFENCE_RDTSC': '"" LFENCE synchronizes RDTSC',
    'ACC_POWER': 'AMD Accumulated Power Mechanism',
    'NOPL': 'The NOPL (0F 1F) instructions',
    'ALWAYS': '"" Always-present feature',
    'XTOPOLOGY': 'CPU topology enum extensions',
    'TSC_RELIABLE': 'TSC is known to be reliable',
    'NONSTOP_TSC': 'TSC does not stop in C states',
    'CPUID': 'CPU has CPUID instruction itself',
    'EXTD_APICID': 'Extended APICID (8 bits)',
    'AMD_DCM': 'AMD multi-node processor',
    'APERFMPERF': 'P-State hardware coordination feedback capability (APERF/MPERF MSRs)',
    'RAPL': 'AMD/Hygon RAPL interface',
    'NONSTOP_TSC_S3': 'TSC doesn\'t stop in S3 state',
    'TSC_KNOWN_FREQ': 'TSC has known frequency',

    // Intel-defined CPU features, CPUID level 0x00000001 (ECX), word 4
    'XMM3': '"pni" SSE-3',
    'PCLMULQDQ': 'PCLMULQDQ instruction',
    'DTES64': '64-bit Debug Store',
    'MWAIT': '"monitor" MONITOR/MWAIT support',
    'DSCPL': '"ds_cpl" CPL-qualified (filtered) Debug Store',
    'VMX': 'Hardware virtualization',
    'SMX': 'Safer Mode eXtensions',
    'EST': 'Enhanced SpeedStep',
    'TM2': 'Thermal Monitor 2',
    'SSSE3': 'Supplemental SSE-3',
    'CID': 'Context ID',
    'SDBG': 'Silicon Debug',
    'FMA': 'Fused multiply-add',
    'CX16': 'CMPXCHG16B instruction',
    'XTPR': 'Send Task Priority Messages',
    'PDCM': 'Perf/Debug Capabilities MSR',
    'PCID': 'Process Context Identifiers',
    'DCA': 'Direct Cache Access',
    'XMM4_1': '"sse4_1" SSE-4.1',
    'XMM4_2': '"sse4_2" SSE-4.2',
    'X2APIC': 'X2APIC',
    'MOVBE': 'MOVBE instruction',
    'POPCNT': 'POPCNT instruction',
    'TSC_DEADLINE_TIMER': 'TSC deadline timer',
    'AES': 'AES instructions',
    'XSAVE': 'XSAVE/XRSTOR/XSETBV/XGETBV instructions',
    'OSXSAVE': '"" XSAVE instruction enabled in the OS',
    'AVX': 'Advanced Vector Extensions',
    'F16C': '16-bit FP conversions',
    'RDRAND': 'RDRAND instruction',
    'HYPERVISOR': 'Running on a hypervisor',

    // VIA/Cyrix/Centaur-defined CPU features, CPUID level 0xC0000001, word 5
    'XSTORE': '"rng" RNG present (xstore)',
    'XSTORE_EN': '"rng_en" RNG enabled',
    'XCRYPT': '"ace" on-CPU crypto (xcrypt)',
    'XCRYPT_EN': '"ace_en" on-CPU crypto enabled',
    'ACE2': 'Advanced Cryptography Engine v2',
    'ACE2_EN': 'ACE v2 enabled',
    'PHE': 'PadLock Hash Engine',
    'PHE_EN': 'PHE enabled',
    'PMM': 'PadLock Montgomery Multiplier',
    'PMM_EN': 'PMM enabled',

    // More extended AMD flags: CPUID level 0x80000001, ECX, word 6
    'LAHF_LM': 'LAHF/SAHF in long mode',
    'CMP_LEGACY': 'If yes HyperThreading not valid',
    'SVM': 'Secure Virtual Machine',
    'EXTAPIC': 'Extended APIC space',
    'CR8_LEGACY': 'CR8 in 32-bit mode',
    'ABM': 'Advanced bit manipulation',
    'SSE4A': 'SSE-4A',
    'MISALIGNSSE': 'Misaligned SSE mode',
    '3DNOWPREFETCH': '3DNow prefetch instructions',
    'OSVW': 'OS Visible Workaround',
    'IBS': 'Instruction Based Sampling',
    'XOP': 'extended AVX instructions',
    'SKINIT': 'SKINIT/STGI instructions',
    'WDT': 'Watchdog timer',
    'LWP': 'Light Weight Profiling',
    'FMA4': '4 operands MAC instructions',
    'TCE': 'Translation Cache Extension',
    'NODEID_MSR': 'NodeId MSR',
    'TBM': 'Trailing Bit Manipulations',
    'TOPOEXT': 'Topology extensions CPUID leafs',
    'PERFCTR_CORE': 'Core performance counter extensions',
    'PERFCTR_NB': 'NB performance counter extensions',
    'BPEXT': 'Data breakpoint extension',
    'PTSC': 'Performance time-stamp counter',
    'PERFCTR_LLC': 'Last Level Cache performance counter extensions',
    'MWAITX': 'MWAIT extension (MONITORX/MWAITX instructions)',

    // Auxiliary flags: Linux defined - For features scattered in various
    // CPUID levels like 0x6, 0xA etc, word 7.
    // Reuse free bits when adding new feature flags!
    'RING3MWAIT': 'Ring 3 MONITOR/MWAIT instructions',
    'CPUID_FAULT': 'Intel CPUID faulting',
    'CPB': 'AMD Core Performance Boost',
    'EPB': 'IA32_ENERGY_PERF_BIAS support',
    'CAT_L3': 'Cache Allocation Technology L3',
    'CAT_L2': 'Cache Allocation Technology L2',
    'CDP_L3': 'Code and Data Prioritization L3',
    'INVPCID_SINGLE': 'Effectively INVPCID && CR4.PCIDE=1',
    'HW_PSTATE': 'AMD HW-PState',
    'PROC_FEEDBACK': 'AMD ProcFeedbackInterface',
    'XCOMPACTED': '"" Use compacted XSTATE (XSAVES or XSAVEC)',
    'PTI': 'Kernel Page Table Isolation enabled',
    'KERNEL_IBRS': '"" Set/clear IBRS on kernel entry/exit',
    'RSB_VMEXIT': '"" Fill RSB on VM-Exit',
    'INTEL_PPIN': 'Intel Processor Inventory Number',
    'CDP_L2': 'Code and Data Prioritization L2',
    'MSR_SPEC_CTRL': '"" MSR SPEC_CTRL is implemented',
    'SSBD': 'Speculative Store Bypass Disable',
    'MBA': 'Memory Bandwidth Allocation',
    'RSB_CTXSW': '"" Fill RSB on context switches',
    'PERFMON_V2': 'AMD Performance Monitoring Version 2',
    'USE_IBPB': '"" Indirect Branch Prediction Barrier enabled',
    'USE_IBRS_FW': '"" Use IBRS during runtime firmware calls',
    'SPEC_STORE_BYPASS_DISABLE': '"" Disable Speculative Store Bypass.',
    'LS_CFG_SSBD': '"" AMD SSBD implementation via LS_CFG MSR',
    'IBRS': 'Indirect Branch Restricted Speculation',
    'IBPB': 'Indirect Branch Prediction Barrier',
    'STIBP': 'Single Thread Indirect Branch Predictors',
    'ZEN': '"" CPU based on Zen microarchitecture',
    'L1TF_PTEINV': '"" L1TF workaround PTE inversion',
    'IBRS_ENHANCED': 'Enhanced IBRS',
    'MSR_IA32_FEAT_CTL': '"" MSR IA32_FEAT_CTL configured',

    // Virtualization flags: Linux defined, word 8
    'TPR_SHADOW': 'Intel TPR Shadow',
    'VNMI': 'Intel Virtual NMI',
    'FLEXPRIORITY': 'Intel FlexPriority',
    'EPT': 'Intel Extended Page Table',
    'VPID': 'Intel Virtual Processor ID',

    'VMMCALL': 'Prefer VMMCALL to VMCALL',
    'XENPV': '"" Xen paravirtual guest',
    'EPT_AD': 'Intel Extended Page Table access-dirty bit',
    'VMCALL': '"" Hypervisor supports the VMCALL instruction',
    'VMW_VMMCALL': '"" VMware prefers VMMCALL hypercall instruction',
    'PVUNLOCK': '"" PV unlock function',
    'VCPUPREEMPT': '"" PV vcpu_is_preempted function',
    'TDX_GUEST': 'Intel Trust Domain Extensions Guest',

    // Intel-defined CPU features, CPUID level 0x00000007:0 (EBX), word 9
    'FSGSBASE': 'RDFSBASE, WRFSBASE, RDGSBASE, WRGSBASE instructions',
    'TSC_ADJUST': 'TSC adjustment MSR 0x3B',
    'SGX': 'Software Guard Extensions',
    'BMI1': '1st group bit manipulation extensions',
    'HLE': 'Hardware Lock Elision',
    'AVX2': 'AVX2 instructions',
    'FDP_EXCPTN_ONLY': '"" FPU data pointer updated only on x87 exceptions',
    'SMEP': 'Supervisor Mode Execution Protection',
    'BMI2': '2nd group bit manipulation extensions',
    'ERMS': 'Enhanced REP MOVSB/STOSB instructions',
    'INVPCID': 'Invalidate Processor Context ID',
    'RTM': 'Restricted Transactional Memory',
    'CQM': 'Cache QoS Monitoring',
    'ZERO_FCS_FDS': '"" Zero out FPU CS and FPU DS',
    'MPX': 'Memory Protection Extension',
    'RDT_A': 'Resource Director Technology Allocation',
    'AVX512F': 'AVX-512 Foundation',
    'AVX512DQ': 'AVX-512 DQ (Double/Quad granular) Instructions',
    'RDSEED': 'RDSEED instruction',
    'ADX': 'ADCX and ADOX instructions',
    'SMAP': 'Supervisor Mode Access Prevention',
    'AVX512IFMA': 'AVX-512 Integer Fused Multiply-Add instructions',
    'CLFLUSHOPT': 'CLFLUSHOPT instruction',
    'CLWB': 'CLWB instruction',
    'INTEL_PT': 'Intel Processor Trace',
    'AVX512PF': 'AVX-512 Prefetch',
    'AVX512ER': 'AVX-512 Exponential and Reciprocal',
    'AVX512CD': 'AVX-512 Conflict Detection',
    'SHA_NI': 'SHA1/SHA256 Instruction Extensions',
    'AVX512BW': 'AVX-512 BW (Byte/Word granular) Instructions',
    'AVX512VL': 'AVX-512 VL (128/256 Vector Length) Extensions',

    // Extended state features, CPUID level 0x0000000d:1 (EAX), word 10
    'XSAVEOPT': 'XSAVEOPT instruction',
    'XSAVEC': 'XSAVEC instruction',
    'XGETBV1': 'XGETBV with ECX = 1 instruction',
    'XSAVES': 'XSAVES/XRSTORS instructions',
    'XFD': '"" eXtended Feature Disabling',

    // Extended auxiliary flags: Linux defined - for features scattered in various
    // CPUID levels like 0xf, etc.
    // Reuse free bits when adding new feature flags!
    'CQM_LLC': 'LLC QoS if 1',
    'CQM_OCCUP_LLC': 'LLC occupancy monitoring',
    'CQM_MBM_TOTAL': 'LLC Total MBM monitoring',
    'CQM_MBM_LOCAL': 'LLC Local MBM monitoring',
    'FENCE_SWAPGS_USER': '"" LFENCE in user entry SWAPGS path',
    'FENCE_SWAPGS_KERNEL': '"" LFENCE in kernel entry SWAPGS path',
    'SPLIT_LOCK_DETECT': '#AC for split lock',
    'PER_THREAD_MBA': '"" Per-thread Memory Bandwidth Allocation',
    'SGX1': '"" Basic SGX',
    'SGX2': '"" SGX Enclave Dynamic Memory Management (EDMM)',
    'ENTRY_IBPB': '"" Issue an IBPB on kernel entry',
    'RRSBA_CTRL': '"" RET prediction control',
    'RETPOLINE': '"" Generic Retpoline mitigation for Spectre variant 2',
    'RETPOLINE_LFENCE': '"" Use LFENCE for Spectre variant 2',
    'RETHUNK': '"" Use REturn THUNK',
    'UNRET': '"" AMD BTB untrain return',
    'USE_IBPB_FW': '"" Use IBPB during runtime firmware calls',
    'RSB_VMEXIT_LITE': '"" Fill RSB on VM exit when EIBRS is enabled',

    // Intel-defined CPU features, CPUID level 0x00000007:1 (EAX), word 12
    'AVX_VNNI': 'AVX VNNI instructions',
    'AVX512_BF16': 'AVX512 BFLOAT16 instructions',

    // AMD-defined CPU features, CPUID level 0x80000008 (EBX), word 13
    'CLZERO': 'CLZERO instruction',
    'IRPERF': 'Instructions Retired Count',
    'XSAVEERPTR': 'Always save/restore FP error pointers',
    'RDPRU': 'Read processor register at user level',
    'WBNOINVD': 'WBNOINVD instruction',
    'AMD_IBPB': '"" Indirect Branch Prediction Barrier',
    'AMD_IBRS': '"" Indirect Branch Restricted Speculation',
    'AMD_STIBP': '"" Single Thread Indirect Branch Predictors',
    'AMD_STIBP_ALWAYS_ON': '"" Single Thread Indirect Branch Predictors always-on preferred',
    'AMD_PPIN': 'Protected Processor Inventory Number',
    'AMD_SSBD': '"" Speculative Store Bypass Disable',
    'VIRT_SSBD': 'Virtualized Speculative Store Bypass Disable',
    'AMD_SSB_NO': '"" Speculative Store Bypass is fixed in hardware.',
    'CPPC': 'Collaborative Processor Performance Control',
    'BTC_NO': '"" Not vulnerable to Branch Type Confusion',
    'BRS': 'Branch Sampling available',

    // Thermal and Power Management Leaf, CPUID level 0x00000006 (EAX), word 14
    'DTHERM': 'Digital Thermal Sensor',
    'IDA': 'Intel Dynamic Acceleration',
    'ARAT': 'Always Running APIC Timer',
    'PLN': 'Intel Power Limit Notification',
    'PTS': 'Intel Package Thermal Status',
    'HWP': 'Intel Hardware P-states',
    'HWP_NOTIFY': 'HWP Notification',
    'HWP_ACT_WINDOW': 'HWP Activity Window',
    'HWP_EPP': 'HWP Energy Perf. Preference',
    'HWP_PKG_REQ': 'HWP Package Level Request',
    'HFI': 'Hardware Feedback Interface',

    // AMD SVM Feature Identification, CPUID level 0x8000000a (EDX), word 15
    'NPT': 'Nested Page Table support',
    'LBRV': 'LBR Virtualization support',
    'SVML': '"svm_lock" SVM locking MSR',
    'NRIPS': '"nrip_save" SVM next_rip save',
    'TSCRATEMSR': '"tsc_scale" TSC scaling support',
    'VMCBCLEAN': '"vmcb_clean" VMCB clean bits support',
    'FLUSHBYASID': 'flush-by-ASID support',
    'DECODEASSISTS': 'Decode Assists support',
    'PAUSEFILTER': 'filtered pause intercept',
    'PFTHRESHOLD': 'pause filter threshold',
    'AVIC': 'Virtual Interrupt Controller',
    'V_VMSAVE_VMLOAD': 'Virtual VMSAVE VMLOAD',
    'VGIF': 'Virtual GIF',
    'X2AVIC': 'Virtual x2apic',
    'V_SPEC_CTRL': 'Virtual SPEC_CTRL',
    'SVME_ADDR_CHK': '"" SVME addr check',

    // Intel-defined CPU features, CPUID level 0x00000007:0 (ECX), word 16
    'AVX512VBMI': 'AVX512 Vector Bit Manipulation instructions',
    'UMIP': 'User Mode Instruction Protection',
    'PKU': 'Protection Keys for Userspace',
    'OSPKE': 'OS Protection Keys Enable',
    'WAITPKG': 'UMONITOR/UMWAIT/TPAUSE Instructions',
    'AVX512_VBMI2': 'Additional AVX512 Vector Bit Manipulation Instructions',
    'GFNI': 'Galois Field New Instructions',
    'VAES': 'Vector AES',
    'VPCLMULQDQ': 'Carry-Less Multiplication Double Quadword',
    'AVX512_VNNI': 'Vector Neural Network Instructions',
    'AVX512_BITALG': 'Support for VPOPCNT[B,W] and VPSHUF-BITQMB instructions',
    'TME': 'Intel Total Memory Encryption',
    'AVX512_VPOPCNTDQ': 'POPCNT for vectors of DW/QW',
    'LA57': '5-level page tables',
    'RDPID': 'RDPID instruction',
    'BUS_LOCK_DETECT': 'Bus Lock detect',
    'CLDEMOTE': 'CLDEMOTE instruction',
    'MOVDIRI': 'MOVDIRI instruction',
    'MOVDIR64B': 'MOVDIR64B instruction',
    'ENQCMD': 'ENQCMD and ENQCMDS instructions',
    'SGX_LC': 'Software Guard Extensions Launch Control',

    // AMD-defined CPU features, CPUID level 0x80000007 (EBX), word 17
    'OVERFLOW_RECOV': 'MCA overflow recovery support',
    'SUCCOR': 'Uncorrectable error containment and recovery',
    'SMCA': 'Scalable MCA',

    // Intel-defined CPU features, CPUID level 0x00000007:0 (EDX), word 18
    'AVX512_4VNNIW': 'AVX-512 Neural Network Instructions',
    'AVX512_4FMAPS': 'AVX-512 Multiply Accumulation Single precision',
    'FSRM': 'Fast Short Rep Mov',
    'AVX512_VP2INTERSECT': 'AVX-512 Intersect for D/Q',
    'SRBDS_CTRL': '"" SRBDS mitigation MSR available',
    'MD_CLEAR': 'VERW clears CPU buffers',
    'RTM_ALWAYS_ABORT': '"" RTM transaction always aborts',
    'TSX_FORCE_ABORT': '"" TSX_FORCE_ABORT',
    'SERIALIZE': 'SERIALIZE instruction',
    'HYBRID_CPU': '"" This part has CPUs of more than one type',
    'TSXLDTRK': 'TSX Suspend Load Address Tracking',
    'PCONFIG': 'Intel PCONFIG',
    'ARCH_LBR': 'Intel ARCH LBR',
    'IBT': 'Indirect Branch Tracking',
    'AMX_BF16': 'AMX bf16 Support',
    'AVX512_FP16': 'AVX512 FP16',
    'AMX_TILE': 'AMX tile Support',
    'AMX_INT8': 'AMX int8 Support',
    'SPEC_CTRL': '"" Speculation Control (IBRS + IBPB)',
    'INTEL_STIBP': '"" Single Thread Indirect Branch Predictors',
    'FLUSH_L1D': 'Flush L1D cache',
    'ARCH_CAPABILITIES': 'IA32_ARCH_CAPABILITIES MSR (Intel)',
    'CORE_CAPABILITIES': '"" IA32_CORE_CAPABILITIES MSR',
    'SPEC_CTRL_SSBD': '"" Speculative Store Bypass Disable',

    // AMD-defined memory encryption features, CPUID level 0x8000001f (EAX), word 19
    'SME': 'AMD Secure Memory Encryption',
    'SEV': 'AMD Secure Encrypted Virtualization',
    'VM_PAGE_FLUSH': '"" VM Page Flush MSR is supported',
    'SEV_ES': 'AMD Secure Encrypted Virtualization - Encrypted State',
    'V_TSC_AUX': '"" Virtual TSC_AUX',
    'SME_COHERENT': '"" AMD hardware-enforced cache coherency',
  };
}

class _SpanishStrings extends Strings {
  @override String get unknown => 'Desconocido';
  @override String get cpuFeatures => 'Características de la CPU';
  @override String get search => 'Buscar por nombre';
  @override Map<String, String> get cpuFlags => {
    'FPU': 'Onboard FPU',
    'VME': 'Extensiones de modo virtual',
    'DE': 'Extensiones de depuración',
    'PSE': 'Extensiones de tamaño de página',
    'TSC': 'Contador de marca de tiempo',
    'MSR': 'Model-Specific Registers',
    'PAE': 'Registros específicos del modelo',
    'MCE': 'Machine Check Exception',
    'CX8': 'Instrucciones CMPXCHG8',
    'APIC': 'Onboard APIC',
    'SEP': 'SYSENTER/SYSEXIT',
    'MTRR': 'Registros de rango de tipo de memoria',
    'PGE': 'Page Global Enable',
    'MCA': 'Arquitectura de verificación de máquina',
    'CMOV': 'Instrucciones CMOV (plus FCMOVcc, FCOMI con FPU)',
    'PAT': 'Tabla de atributos de página',
    'PSE36': '36-bit PSEs',
    'PN': 'Número de serie del procesador',
    'CLFLUSH': 'Instrucción CLFLUSH',
    'DS': 'Almacenamiento de depuración',
    'DTS': 'Almacenamiento de depuración',
    'ACPI': 'ACPI vía MSR',
    'MMX': 'Extensiones de multimedia',
    'FXSR': 'FXSAVE/FXRSTOR, CR4.OSFXSR',
    'XMM': '"sse"',
    'XMM2': '"sse2"',
    'SELFSNOOP': '"ss" CPU self snoop',
    'HT': 'Hyper-Threading',
    'ACC': '"tm" Control automático de reloj',
    'IA64': 'Procesador IA-64',
    'PBE': 'Pending Break Enable',

    // AMD-defined CPU features, CPUID level 0x80000001, word 1
    // Don't duplicate feature flags which are redundant with Intel!
    'SYSCALL': 'SYSCALL/SYSRET',
    'MP': 'Capacidad MP',
    'NX': 'Ejecución deshabilitada',
    'MMXEXT': 'Extensiones AMD MMX',
    'FXSR_OPT': 'Optimizaciones FXSAVE/FXRSTOR',
    'GBPAGES': 'GB pages',
    "PDPE1GB": "GB pages",
    'RDTSCP': 'RDTSCP',
    'LM': 'Long Mode (x86-64, 64-bit support)',
    '3DNOWEXT': 'Extensiones AMD 3DNow',
    '3DNOW': '3DNow',

    // Transmeta-defined CPU features, CPUID level 0x80860001, word 2
    'RECOVERY': 'CPU en modo de recuperación',
    'LONGRUN': 'Longrun power control',
    'LRTI': 'LongRun table interface',

    // Other features, Linux-defined mapping, word 3
    // This range is used for feature bits which conflict or are synthesized
    'CXMMX': 'Extensiones Cyrix MMX',
    'K6_MTRR': 'AMD K6 no estandard MTRRs',
    'CYRIX_ARR': 'Cyrix ARRs (= MTRRs)',
    'CENTAUR_MCR': 'Centaur MCRs (= MTRRs)',

    // CPU types for specific tunings:
    'K8': '"" Opteron, Athlon64',
    // FREE, was #define X86_FEATURE_K7	((3 * 32) + 5) "" Athlon
    'P3': '"" P3',
    'P4': '"" P4',
    'CONSTANT_TSC': 'TSC ticks a una tasa constante',
    'UP': 'Kernel SMP ejecutándose en UP',
    'ART': 'Temporizador siempre funcionando (ART)',
    'ARCH_PERFMON': 'Intel Architectural PerfMon',
    'PEBS': 'Precise-Event Based Sampling',
    'BTS': 'Branch Trace Store',
    'SYSCALL32': '"" syscall in IA32 userspace',
    'SYSENTER32': '"" sysenter in IA32 userspace',
    'REP_GOOD': 'REP microcode works well',
    // FREE! ((3 * 32) + 17)
    'LFENCE_RDTSC': '"" LFENCE synchronizes RDTSC',
    'ACC_POWER': 'AMD Accumulated Power Mechanism',
    'NOPL': 'The NOPL (0F 1F) instructions',
    'ALWAYS': '"" Always-present feature',
    'XTOPOLOGY': 'CPU topology enum extensions',
    'TSC_RELIABLE': 'TSC is known to be reliable',
    'NONSTOP_TSC': 'TSC does not stop in C states',
    'CPUID': 'CPU has CPUID instruction itself',
    'EXTD_APICID': 'Extended APICID (8 bits)',
    'AMD_DCM': 'AMD multi-node processor',
    'APERFMPERF': 'P-State hardware coordination feedback capability (APERF/MPERF MSRs)',
    'RAPL': 'AMD/Hygon RAPL interface',
    'NONSTOP_TSC_S3': 'TSC doesn\'t stop in S3 state',
    'TSC_KNOWN_FREQ': 'TSC has known frequency',

    // Intel-defined CPU features, CPUID level 0x00000001 (ECX), word 4
    'XMM3': '"pni" SSE-3',
    'PCLMULQDQ': 'PCLMULQDQ instruction',
    'DTES64': '64-bit Debug Store',
    'MWAIT': '"monitor" MONITOR/MWAIT support',
    'DSCPL': '"ds_cpl" CPL-qualified (filtered) Debug Store',
    'VMX': 'Hardware virtualization',
    'SMX': 'Safer Mode eXtensions',
    'EST': 'Enhanced SpeedStep',
    'TM2': 'Thermal Monitor 2',
    'SSSE3': 'Supplemental SSE-3',
    'CID': 'Context ID',
    'SDBG': 'Silicon Debug',
    'FMA': 'Fused multiply-add',
    'CX16': 'CMPXCHG16B instruction',
    'XTPR': 'Send Task Priority Messages',
    'PDCM': 'Perf/Debug Capabilities MSR',
    'PCID': 'Process Context Identifiers',
    'DCA': 'Direct Cache Access',
    'XMM4_1': '"sse4_1" SSE-4.1',
    'XMM4_2': '"sse4_2" SSE-4.2',
    'X2APIC': 'X2APIC',
    'MOVBE': 'Instrucciones MOVBE',
    'POPCNT': 'Instrucciones POPCNT',
    'TSC_DEADLINE_TIMER': 'TSC deadline timer',
    'AES': 'Instrucciones AES',
    'XSAVE': 'XSAVE/XRSTOR/XSETBV/XGETBV instructions',
    'OSXSAVE': '"" XSAVE instruction enabled in the OS',
    'AVX': 'Extensiones de vectores avanzados',
    'F16C': '16-bit FP conversions',
    'RDRAND': 'RDRAND instruction',
    'HYPERVISOR': 'Ejecutando en un hypervisor',

    // VIA/Cyrix/Centaur-defined CPU features, CPUID level 0xC0000001, word 5
    'XSTORE': '"rng" RNG present (xstore)',
    'XSTORE_EN': '"rng_en" RNG enabled',
    'XCRYPT': '"ace" on-CPU crypto (xcrypt)',
    'XCRYPT_EN': '"ace_en" on-CPU crypto enabled',
    'ACE2': 'Advanced Cryptography Engine v2',
    'ACE2_EN': 'ACE v2 enabled',
    'PHE': 'PadLock Hash Engine',
    'PHE_EN': 'PHE enabled',
    'PMM': 'PadLock Montgomery Multiplier',
    'PMM_EN': 'PMM enabled',

    // More extended AMD flags: CPUID level 0x80000001, ECX, word 6
    'LAHF_LM': 'LAHF/SAHF in long mode',
    'CMP_LEGACY': 'If yes HyperThreading not valid',
    'SVM': 'Secure Virtual Machine',
    'EXTAPIC': 'Extended APIC space',
    'CR8_LEGACY': 'CR8 in 32-bit mode',
    'ABM': 'Advanced bit manipulation',
    'SSE4A': 'SSE-4A',
    'MISALIGNSSE': 'Misaligned SSE mode',
    '3DNOWPREFETCH': 'Instrucciones 3DNow prefetch',
    'OSVW': 'OS Visible Workaround',
    'IBS': 'Instruction Based Sampling',
    'XOP': 'extended AVX instructions',
    'SKINIT': 'SKINIT/STGI instructions',
    'WDT': 'Watchdog timer',
    'LWP': 'Light Weight Profiling',
    'FMA4': '4 operands MAC instructions',
    'TCE': 'Translation Cache Extension',
    'NODEID_MSR': 'NodeId MSR',
    'TBM': 'Trailing Bit Manipulations',
    'TOPOEXT': 'Topology extensions CPUID leafs',
    'PERFCTR_CORE': 'Core performance counter extensions',
    'PERFCTR_NB': 'NB performance counter extensions',
    'BPEXT': 'Data breakpoint extension',
    'PTSC': 'Performance time-stamp counter',
    'PERFCTR_LLC': 'Last Level Cache performance counter extensions',
    'MWAITX': 'MWAIT extension (MONITORX/MWAITX instructions)',

    // Auxiliary flags: Linux defined - For features scattered in various
    // CPUID levels like 0x6, 0xA etc, word 7.
    // Reuse free bits when adding new feature flags!
    'RING3MWAIT': 'Ring 3 MONITOR/MWAIT instructions',
    'CPUID_FAULT': 'Intel CPUID faulting',
    'CPB': 'AMD Core Performance Boost',
    'EPB': 'IA32_ENERGY_PERF_BIAS support',
    'CAT_L3': 'Cache Allocation Technology L3',
    'CAT_L2': 'Cache Allocation Technology L2',
    'CDP_L3': 'Code and Data Prioritization L3',
    'INVPCID_SINGLE': 'Effectively INVPCID && CR4.PCIDE=1',
    'HW_PSTATE': 'AMD HW-PState',
    'PROC_FEEDBACK': 'AMD ProcFeedbackInterface',
    'XCOMPACTED': '"" Use compacted XSTATE (XSAVES or XSAVEC)',
    'PTI': 'Kernel Page Table Isolation enabled',
    'KERNEL_IBRS': '"" Set/clear IBRS on kernel entry/exit',
    'RSB_VMEXIT': '"" Fill RSB on VM-Exit',
    'INTEL_PPIN': 'Intel Processor Inventory Number',
    'CDP_L2': 'Code and Data Prioritization L2',
    'MSR_SPEC_CTRL': '"" MSR SPEC_CTRL is implemented',
    'SSBD': 'Speculative Store Bypass Disable',
    'MBA': 'Memory Bandwidth Allocation',
    'RSB_CTXSW': '"" Fill RSB on context switches',
    'PERFMON_V2': 'AMD Performance Monitoring Version 2',
    'USE_IBPB': '"" Indirect Branch Prediction Barrier enabled',
    'USE_IBRS_FW': '"" Use IBRS during runtime firmware calls',
    'SPEC_STORE_BYPASS_DISABLE': '"" Disable Speculative Store Bypass.',
    'LS_CFG_SSBD': '"" AMD SSBD implementation via LS_CFG MSR',
    'IBRS': 'Indirect Branch Restricted Speculation',
    'IBPB': 'Indirect Branch Prediction Barrier',
    'STIBP': 'Single Thread Indirect Branch Predictors',
    'ZEN': '"" CPU based on Zen microarchitecture',
    'L1TF_PTEINV': '"" L1TF workaround PTE inversion',
    'IBRS_ENHANCED': 'Enhanced IBRS',
    'MSR_IA32_FEAT_CTL': '"" MSR IA32_FEAT_CTL configured',

    // Virtualization flags: Linux defined, word 8
    'TPR_SHADOW': 'Intel TPR Shadow',
    'VNMI': 'Intel Virtual NMI',
    'FLEXPRIORITY': 'Intel FlexPriority',
    'EPT': 'Intel Extended Page Table',
    'VPID': 'Intel Virtual Processor ID',

    'VMMCALL': 'Prefer VMMCALL to VMCALL',
    'XENPV': '"" Xen paravirtual guest',
    'EPT_AD': 'Intel Extended Page Table access-dirty bit',
    'VMCALL': '"" Hypervisor supports the VMCALL instruction',
    'VMW_VMMCALL': '"" VMware prefers VMMCALL hypercall instruction',
    'PVUNLOCK': '"" PV unlock function',
    'VCPUPREEMPT': '"" PV vcpu_is_preempted function',
    'TDX_GUEST': 'Intel Trust Domain Extensions Guest',

    // Intel-defined CPU features, CPUID level 0x00000007:0 (EBX), word 9
    'FSGSBASE': 'RDFSBASE, WRFSBASE, RDGSBASE, WRGSBASE instructions',
    'TSC_ADJUST': 'TSC adjustment MSR 0x3B',
    'SGX': 'Software Guard Extensions',
    'BMI1': '1st group bit manipulation extensions',
    'HLE': 'Hardware Lock Elision',
    'AVX2': 'AVX2 instructions',
    'FDP_EXCPTN_ONLY': '"" FPU data pointer updated only on x87 exceptions',
    'SMEP': 'Supervisor Mode Execution Protection',
    'BMI2': '2nd group bit manipulation extensions',
    'ERMS': 'Enhanced REP MOVSB/STOSB instructions',
    'INVPCID': 'Invalidate Processor Context ID',
    'RTM': 'Restricted Transactional Memory',
    'CQM': 'Cache QoS Monitoring',
    'ZERO_FCS_FDS': '"" Zero out FPU CS and FPU DS',
    'MPX': 'Memory Protection Extension',
    'RDT_A': 'Resource Director Technology Allocation',
    'AVX512F': 'AVX-512 Foundation',
    'AVX512DQ': 'AVX-512 DQ (Double/Quad granular) Instructions',
    'RDSEED': 'RDSEED instruction',
    'ADX': 'ADCX and ADOX instructions',
    'SMAP': 'Supervisor Mode Access Prevention',
    'AVX512IFMA': 'AVX-512 Integer Fused Multiply-Add instructions',
    'CLFLUSHOPT': 'CLFLUSHOPT instruction',
    'CLWB': 'CLWB instruction',
    'INTEL_PT': 'Intel Processor Trace',
    'AVX512PF': 'AVX-512 Prefetch',
    'AVX512ER': 'AVX-512 Exponential and Reciprocal',
    'AVX512CD': 'AVX-512 Conflict Detection',
    'SHA_NI': 'SHA1/SHA256 Instruction Extensions',
    'AVX512BW': 'AVX-512 BW (Byte/Word granular) Instructions',
    'AVX512VL': 'AVX-512 VL (128/256 Vector Length) Extensions',

    // Extended state features, CPUID level 0x0000000d:1 (EAX), word 10
    'XSAVEOPT': 'XSAVEOPT instruction',
    'XSAVEC': 'XSAVEC instruction',
    'XGETBV1': 'XGETBV with ECX = 1 instruction',
    'XSAVES': 'XSAVES/XRSTORS instructions',
    'XFD': '"" eXtended Feature Disabling',

    // Extended auxiliary flags: Linux defined - for features scattered in various
    // CPUID levels like 0xf, etc.
    // Reuse free bits when adding new feature flags!
    'CQM_LLC': 'LLC QoS if 1',
    'CQM_OCCUP_LLC': 'LLC occupancy monitoring',
    'CQM_MBM_TOTAL': 'LLC Total MBM monitoring',
    'CQM_MBM_LOCAL': 'LLC Local MBM monitoring',
    'FENCE_SWAPGS_USER': '"" LFENCE in user entry SWAPGS path',
    'FENCE_SWAPGS_KERNEL': '"" LFENCE in kernel entry SWAPGS path',
    'SPLIT_LOCK_DETECT': '#AC for split lock',
    'PER_THREAD_MBA': '"" Per-thread Memory Bandwidth Allocation',
    'SGX1': '"" Basic SGX',
    'SGX2': '"" SGX Enclave Dynamic Memory Management (EDMM)',
    'ENTRY_IBPB': '"" Issue an IBPB on kernel entry',
    'RRSBA_CTRL': '"" RET prediction control',
    'RETPOLINE': '"" Generic Retpoline mitigation for Spectre variant 2',
    'RETPOLINE_LFENCE': '"" Use LFENCE for Spectre variant 2',
    'RETHUNK': '"" Use REturn THUNK',
    'UNRET': '"" AMD BTB untrain return',
    'USE_IBPB_FW': '"" Use IBPB during runtime firmware calls',
    'RSB_VMEXIT_LITE': '"" Fill RSB on VM exit when EIBRS is enabled',

    // Intel-defined CPU features, CPUID level 0x00000007:1 (EAX), word 12
    'AVX_VNNI': 'AVX VNNI instructions',
    'AVX512_BF16': 'AVX512 BFLOAT16 instructions',

    // AMD-defined CPU features, CPUID level 0x80000008 (EBX), word 13
    'CLZERO': 'CLZERO instruction',
    'IRPERF': 'Instructions Retired Count',
    'XSAVEERPTR': 'Always save/restore FP error pointers',
    'RDPRU': 'Read processor register at user level',
    'WBNOINVD': 'WBNOINVD instruction',
    'AMD_IBPB': '"" Indirect Branch Prediction Barrier',
    'AMD_IBRS': '"" Indirect Branch Restricted Speculation',
    'AMD_STIBP': '"" Single Thread Indirect Branch Predictors',
    'AMD_STIBP_ALWAYS_ON': '"" Single Thread Indirect Branch Predictors always-on preferred',
    'AMD_PPIN': 'Protected Processor Inventory Number',
    'AMD_SSBD': '"" Speculative Store Bypass Disable',
    'VIRT_SSBD': 'Virtualized Speculative Store Bypass Disable',
    'AMD_SSB_NO': '"" Speculative Store Bypass is fixed in hardware.',
    'CPPC': 'Collaborative Processor Performance Control',
    'BTC_NO': '"" Not vulnerable to Branch Type Confusion',
    'BRS': 'Branch Sampling available',

    // Thermal and Power Management Leaf, CPUID level 0x00000006 (EAX), word 14
    'DTHERM': 'Digital Thermal Sensor',
    'IDA': 'Intel Dynamic Acceleration',
    'ARAT': 'Always Running APIC Timer',
    'PLN': 'Intel Power Limit Notification',
    'PTS': 'Intel Package Thermal Status',
    'HWP': 'Intel Hardware P-states',
    'HWP_NOTIFY': 'HWP Notification',
    'HWP_ACT_WINDOW': 'HWP Activity Window',
    'HWP_EPP': 'HWP Energy Perf. Preference',
    'HWP_PKG_REQ': 'HWP Package Level Request',
    'HFI': 'Hardware Feedback Interface',

    // AMD SVM Feature Identification, CPUID level 0x8000000a (EDX), word 15
    'NPT': 'Nested Page Table support',
    'LBRV': 'LBR Virtualization support',
    'SVML': '"svm_lock" SVM locking MSR',
    'NRIPS': 'SVM next_rip save',
    "NRIP_SAVE": 'SVM next_rip save',
    'TSCRATEMSR': '"tsc_scale" TSC scaling support',
    'VMCBCLEAN': '"vmcb_clean" VMCB clean bits support',
    'FLUSHBYASID': 'flush-by-ASID support',
    'DECODEASSISTS': 'Decode Assists support',
    'PAUSEFILTER': 'filtered pause intercept',
    'PFTHRESHOLD': 'pause filter threshold',
    'AVIC': 'Virtual Interrupt Controller',
    'V_VMSAVE_VMLOAD': 'Virtual VMSAVE VMLOAD',
    'VGIF': 'Virtual GIF',
    'X2AVIC': 'Virtual x2apic',
    'V_SPEC_CTRL': 'Virtual SPEC_CTRL',
    'SVME_ADDR_CHK': '"" SVME addr check',

    // Intel-defined CPU features, CPUID level 0x00000007:0 (ECX), word 16
    'AVX512VBMI': 'AVX512 Vector Bit Manipulation instructions',
    'UMIP': 'User Mode Instruction Protection',
    'PKU': 'Protection Keys for Userspace',
    'OSPKE': 'OS Protection Keys Enable',
    'WAITPKG': 'UMONITOR/UMWAIT/TPAUSE Instructions',
    'AVX512_VBMI2': 'Additional AVX512 Vector Bit Manipulation Instructions',
    'GFNI': 'Galois Field New Instructions',
    'VAES': 'Vector AES',
    'VPCLMULQDQ': 'Carry-Less Multiplication Double Quadword',
    'AVX512_VNNI': 'Vector Neural Network Instructions',
    'AVX512_BITALG': 'Support for VPOPCNT[B,W] and VPSHUF-BITQMB instructions',
    'TME': 'Intel Total Memory Encryption',
    'AVX512_VPOPCNTDQ': 'POPCNT for vectors of DW/QW',
    'LA57': '5-level page tables',
    'RDPID': 'RDPID instruction',
    'BUS_LOCK_DETECT': 'Bus Lock detect',
    'CLDEMOTE': 'CLDEMOTE instruction',
    'MOVDIRI': 'MOVDIRI instruction',
    'MOVDIR64B': 'MOVDIR64B instruction',
    'ENQCMD': 'ENQCMD and ENQCMDS instructions',
    'SGX_LC': 'Software Guard Extensions Launch Control',

    // AMD-defined CPU features, CPUID level 0x80000007 (EBX), word 17
    'OVERFLOW_RECOV': 'MCA overflow recovery support',
    'SUCCOR': 'Uncorrectable error containment and recovery',
    'SMCA': 'Scalable MCA',

    // Intel-defined CPU features, CPUID level 0x00000007:0 (EDX), word 18
    'AVX512_4VNNIW': 'AVX-512 Neural Network Instructions',
    'AVX512_4FMAPS': 'AVX-512 Multiply Accumulation Single precision',
    'FSRM': 'Fast Short Rep Mov',
    'AVX512_VP2INTERSECT': 'AVX-512 Intersect for D/Q',
    'SRBDS_CTRL': '"" SRBDS mitigation MSR available',
    'MD_CLEAR': 'VERW clears CPU buffers',
    'RTM_ALWAYS_ABORT': '"" RTM transaction always aborts',
    'TSX_FORCE_ABORT': '"" TSX_FORCE_ABORT',
    'SERIALIZE': 'SERIALIZE instruction',
    'HYBRID_CPU': '"" This part has CPUs of more than one type',
    'TSXLDTRK': 'TSX Suspend Load Address Tracking',
    'PCONFIG': 'Intel PCONFIG',
    'ARCH_LBR': 'Intel ARCH LBR',
    'IBT': 'Indirect Branch Tracking',
    'AMX_BF16': 'AMX bf16 Support',
    'AVX512_FP16': 'AVX512 FP16',
    'AMX_TILE': 'AMX tile Support',
    'AMX_INT8': 'AMX int8 Support',
    'SPEC_CTRL': '"" Speculation Control (IBRS + IBPB)',
    'INTEL_STIBP': '"" Single Thread Indirect Branch Predictors',
    'FLUSH_L1D': 'Flush L1D cache',
    'ARCH_CAPABILITIES': 'IA32_ARCH_CAPABILITIES MSR (Intel)',
    'CORE_CAPABILITIES': '"" IA32_CORE_CAPABILITIES MSR',
    'SPEC_CTRL_SSBD': '"" Speculative Store Bypass Disable',

    // AMD-defined memory encryption features, CPUID level 0x8000001f (EAX), word 19
    'SME': 'AMD Secure Memory Encryption',
    'SEV': 'AMD Secure Encrypted Virtualization',
    'VM_PAGE_FLUSH': '"" VM Page Flush MSR is supported',
    'SEV_ES': 'AMD Secure Encrypted Virtualization - Encrypted State',
    'V_TSC_AUX': '"" Virtual TSC_AUX',
    'SME_COHERENT': '"" AMD hardware-enforced cache coherency',
  };
}

class _EsperantoStrings extends Strings {
  @override String get unknown => 'Nekonata';
  @override String get cpuFeatures => 'Funkcioj de CPU';
  @override String get search => 'Serĉu laŭ nomo';
  @override Map<String, String> get cpuFlags => {
    'FPU': 'Onboard FPU',
    'VME': 'Virtual Mode Extensions',
    'DE': 'Debugging Extensions',
    'PSE': 'Page Size Extensions',
    'TSC': 'Time Stamp Counter',
    'MSR': 'Model-Specific Registers',
    'PAE': 'Physical Address Extensions',
    'MCE': 'Machine Check Exception',
    'CX8': 'CMPXCHG8 instruction',
    'APIC': 'Onboard APIC',
    'SEP': 'SYSENTER/SYSEXIT',
    'MTRR': 'Memory Type Range Registers',
    'PGE': 'Page Global Enable',
    'MCA': 'Machine Check Architecture',
    'CMOV': 'CMOV instructions (plus FCMOVcc, FCOMI with FPU)',
    'PAT': 'Page Attribute Table',
    'PSE36': '36-bit PSEs',
    'PN': 'Processor serial number',
    'CLFLUSH': 'CLFLUSH instruction',
    'DS': '"dts" Debug Store',
    'ACPI': 'ACPI via MSR',
    'MMX': 'Multimedia Extensions',
    'FXSR': 'FXSAVE/FXRSTOR, CR4.OSFXSR',
    'XMM': '"sse"',
    'XMM2': '"sse2"',
    'SELFSNOOP': '"ss" CPU self snoop',
    'HT': 'Hyper-Threading',
    'ACC': '"tm" Automatic clock control',
    'IA64': 'IA-64 processor',
    'PBE': 'Pending Break Enable',

    // AMD-defined CPU features, CPUID level 0x80000001, word 1
    // Don't duplicate feature flags which are redundant with Intel!
    'SYSCALL': 'SYSCALL/SYSRET',
    'MP': 'MP Capable',
    'NX': 'Execute Disable',
    'MMXEXT': 'AMD MMX extensions',
    'FXSR_OPT': 'FXSAVE/FXRSTOR optimizations',
    'GBPAGES': '"pdpe1gb" GB pages',
    'RDTSCP': 'RDTSCP',
    'LM': 'Long Mode (x86-64, 64-bit support)',
    '3DNOWEXT': 'AMD 3DNow extensions',
    '3DNOW': '3DNow',

    // Transmeta-defined CPU features, CPUID level 0x80860001, word 2
    'RECOVERY': 'CPU in recovery mode',
    'LONGRUN': 'Longrun power control',
    'LRTI': 'LongRun table interface',

    // Other features, Linux-defined mapping, word 3
    // This range is used for feature bits which conflict or are synthesized
    'CXMMX': 'Cyrix MMX extensions',
    'K6_MTRR': 'AMD K6 nonstandard MTRRs',
    'CYRIX_ARR': 'Cyrix ARRs (= MTRRs)',
    'CENTAUR_MCR': 'Centaur MCRs (= MTRRs)',

    // CPU types for specific tunings:
    'K8': '"" Opteron, Athlon64',
    // FREE, was #define X86_FEATURE_K7	((3 * 32) + 5) "" Athlon
    'P3': '"" P3',
    'P4': '"" P4',
    'CONSTANT_TSC': 'TSC ticks at a constant rate',
    'UP': 'SMP kernel running on UP',
    'ART': 'Always running timer (ART)',
    'ARCH_PERFMON': 'Intel Architectural PerfMon',
    'PEBS': 'Precise-Event Based Sampling',
    'BTS': 'Branch Trace Store',
    'SYSCALL32': '"" syscall in IA32 userspace',
    'SYSENTER32': '"" sysenter in IA32 userspace',
    'REP_GOOD': 'REP microcode works well',
    // FREE! ((3 * 32) + 17)
    'LFENCE_RDTSC': '"" LFENCE synchronizes RDTSC',
    'ACC_POWER': 'AMD Accumulated Power Mechanism',
    'NOPL': 'The NOPL (0F 1F) instructions',
    'ALWAYS': '"" Always-present feature',
    'XTOPOLOGY': 'CPU topology enum extensions',
    'TSC_RELIABLE': 'TSC is known to be reliable',
    'NONSTOP_TSC': 'TSC does not stop in C states',
    'CPUID': 'CPU has CPUID instruction itself',
    'EXTD_APICID': 'Extended APICID (8 bits)',
    'AMD_DCM': 'AMD multi-node processor',
    'APERFMPERF': 'P-State hardware coordination feedback capability (APERF/MPERF MSRs)',
    'RAPL': 'AMD/Hygon RAPL interface',
    'NONSTOP_TSC_S3': 'TSC doesn\'t stop in S3 state',
    'TSC_KNOWN_FREQ': 'TSC has known frequency',

    // Intel-defined CPU features, CPUID level 0x00000001 (ECX), word 4
    'XMM3': '"pni" SSE-3',
    'PCLMULQDQ': 'PCLMULQDQ instruction',
    'DTES64': '64-bit Debug Store',
    'MWAIT': '"monitor" MONITOR/MWAIT support',
    'DSCPL': '"ds_cpl" CPL-qualified (filtered) Debug Store',
    'VMX': 'Hardware virtualization',
    'SMX': 'Safer Mode eXtensions',
    'EST': 'Enhanced SpeedStep',
    'TM2': 'Thermal Monitor 2',
    'SSSE3': 'Supplemental SSE-3',
    'CID': 'Context ID',
    'SDBG': 'Silicon Debug',
    'FMA': 'Fused multiply-add',
    'CX16': 'CMPXCHG16B instruction',
    'XTPR': 'Send Task Priority Messages',
    'PDCM': 'Perf/Debug Capabilities MSR',
    'PCID': 'Process Context Identifiers',
    'DCA': 'Direct Cache Access',
    'XMM4_1': '"sse4_1" SSE-4.1',
    'XMM4_2': '"sse4_2" SSE-4.2',
    'X2APIC': 'X2APIC',
    'MOVBE': 'MOVBE instruction',
    'POPCNT': 'POPCNT instruction',
    'TSC_DEADLINE_TIMER': 'TSC deadline timer',
    'AES': 'AES instructions',
    'XSAVE': 'XSAVE/XRSTOR/XSETBV/XGETBV instructions',
    'OSXSAVE': '"" XSAVE instruction enabled in the OS',
    'AVX': 'Advanced Vector Extensions',
    'F16C': '16-bit FP conversions',
    'RDRAND': 'RDRAND instruction',
    'HYPERVISOR': 'Running on a hypervisor',

    // VIA/Cyrix/Centaur-defined CPU features, CPUID level 0xC0000001, word 5
    'XSTORE': '"rng" RNG present (xstore)',
    'XSTORE_EN': '"rng_en" RNG enabled',
    'XCRYPT': '"ace" on-CPU crypto (xcrypt)',
    'XCRYPT_EN': '"ace_en" on-CPU crypto enabled',
    'ACE2': 'Advanced Cryptography Engine v2',
    'ACE2_EN': 'ACE v2 enabled',
    'PHE': 'PadLock Hash Engine',
    'PHE_EN': 'PHE enabled',
    'PMM': 'PadLock Montgomery Multiplier',
    'PMM_EN': 'PMM enabled',

    // More extended AMD flags: CPUID level 0x80000001, ECX, word 6
    'LAHF_LM': 'LAHF/SAHF in long mode',
    'CMP_LEGACY': 'If yes HyperThreading not valid',
    'SVM': 'Secure Virtual Machine',
    'EXTAPIC': 'Extended APIC space',
    'CR8_LEGACY': 'CR8 in 32-bit mode',
    'ABM': 'Advanced bit manipulation',
    'SSE4A': 'SSE-4A',
    'MISALIGNSSE': 'Misaligned SSE mode',
    '3DNOWPREFETCH': '3DNow prefetch instructions',
    'OSVW': 'OS Visible Workaround',
    'IBS': 'Instruction Based Sampling',
    'XOP': 'extended AVX instructions',
    'SKINIT': 'SKINIT/STGI instructions',
    'WDT': 'Watchdog timer',
    'LWP': 'Light Weight Profiling',
    'FMA4': '4 operands MAC instructions',
    'TCE': 'Translation Cache Extension',
    'NODEID_MSR': 'NodeId MSR',
    'TBM': 'Trailing Bit Manipulations',
    'TOPOEXT': 'Topology extensions CPUID leafs',
    'PERFCTR_CORE': 'Core performance counter extensions',
    'PERFCTR_NB': 'NB performance counter extensions',
    'BPEXT': 'Data breakpoint extension',
    'PTSC': 'Performance time-stamp counter',
    'PERFCTR_LLC': 'Last Level Cache performance counter extensions',
    'MWAITX': 'MWAIT extension (MONITORX/MWAITX instructions)',

    // Auxiliary flags: Linux defined - For features scattered in various
    // CPUID levels like 0x6, 0xA etc, word 7.
    // Reuse free bits when adding new feature flags!
    'RING3MWAIT': 'Ring 3 MONITOR/MWAIT instructions',
    'CPUID_FAULT': 'Intel CPUID faulting',
    'CPB': 'AMD Core Performance Boost',
    'EPB': 'IA32_ENERGY_PERF_BIAS support',
    'CAT_L3': 'Cache Allocation Technology L3',
    'CAT_L2': 'Cache Allocation Technology L2',
    'CDP_L3': 'Code and Data Prioritization L3',
    'INVPCID_SINGLE': 'Effectively INVPCID && CR4.PCIDE=1',
    'HW_PSTATE': 'AMD HW-PState',
    'PROC_FEEDBACK': 'AMD ProcFeedbackInterface',
    'XCOMPACTED': '"" Use compacted XSTATE (XSAVES or XSAVEC)',
    'PTI': 'Kernel Page Table Isolation enabled',
    'KERNEL_IBRS': '"" Set/clear IBRS on kernel entry/exit',
    'RSB_VMEXIT': '"" Fill RSB on VM-Exit',
    'INTEL_PPIN': 'Intel Processor Inventory Number',
    'CDP_L2': 'Code and Data Prioritization L2',
    'MSR_SPEC_CTRL': '"" MSR SPEC_CTRL is implemented',
    'SSBD': 'Speculative Store Bypass Disable',
    'MBA': 'Memory Bandwidth Allocation',
    'RSB_CTXSW': '"" Fill RSB on context switches',
    'PERFMON_V2': 'AMD Performance Monitoring Version 2',
    'USE_IBPB': '"" Indirect Branch Prediction Barrier enabled',
    'USE_IBRS_FW': '"" Use IBRS during runtime firmware calls',
    'SPEC_STORE_BYPASS_DISABLE': '"" Disable Speculative Store Bypass.',
    'LS_CFG_SSBD': '"" AMD SSBD implementation via LS_CFG MSR',
    'IBRS': 'Indirect Branch Restricted Speculation',
    'IBPB': 'Indirect Branch Prediction Barrier',
    'STIBP': 'Single Thread Indirect Branch Predictors',
    'ZEN': '"" CPU based on Zen microarchitecture',
    'L1TF_PTEINV': '"" L1TF workaround PTE inversion',
    'IBRS_ENHANCED': 'Enhanced IBRS',
    'MSR_IA32_FEAT_CTL': '"" MSR IA32_FEAT_CTL configured',

    // Virtualization flags: Linux defined, word 8
    'TPR_SHADOW': 'Intel TPR Shadow',
    'VNMI': 'Intel Virtual NMI',
    'FLEXPRIORITY': 'Intel FlexPriority',
    'EPT': 'Intel Extended Page Table',
    'VPID': 'Intel Virtual Processor ID',

    'VMMCALL': 'Prefer VMMCALL to VMCALL',
    'XENPV': '"" Xen paravirtual guest',
    'EPT_AD': 'Intel Extended Page Table access-dirty bit',
    'VMCALL': '"" Hypervisor supports the VMCALL instruction',
    'VMW_VMMCALL': '"" VMware prefers VMMCALL hypercall instruction',
    'PVUNLOCK': '"" PV unlock function',
    'VCPUPREEMPT': '"" PV vcpu_is_preempted function',
    'TDX_GUEST': 'Intel Trust Domain Extensions Guest',

    // Intel-defined CPU features, CPUID level 0x00000007:0 (EBX), word 9
    'FSGSBASE': 'RDFSBASE, WRFSBASE, RDGSBASE, WRGSBASE instructions',
    'TSC_ADJUST': 'TSC adjustment MSR 0x3B',
    'SGX': 'Software Guard Extensions',
    'BMI1': '1st group bit manipulation extensions',
    'HLE': 'Hardware Lock Elision',
    'AVX2': 'AVX2 instructions',
    'FDP_EXCPTN_ONLY': '"" FPU data pointer updated only on x87 exceptions',
    'SMEP': 'Supervisor Mode Execution Protection',
    'BMI2': '2nd group bit manipulation extensions',
    'ERMS': 'Enhanced REP MOVSB/STOSB instructions',
    'INVPCID': 'Invalidate Processor Context ID',
    'RTM': 'Restricted Transactional Memory',
    'CQM': 'Cache QoS Monitoring',
    'ZERO_FCS_FDS': '"" Zero out FPU CS and FPU DS',
    'MPX': 'Memory Protection Extension',
    'RDT_A': 'Resource Director Technology Allocation',
    'AVX512F': 'AVX-512 Foundation',
    'AVX512DQ': 'AVX-512 DQ (Double/Quad granular) Instructions',
    'RDSEED': 'RDSEED instruction',
    'ADX': 'ADCX and ADOX instructions',
    'SMAP': 'Supervisor Mode Access Prevention',
    'AVX512IFMA': 'AVX-512 Integer Fused Multiply-Add instructions',
    'CLFLUSHOPT': 'CLFLUSHOPT instruction',
    'CLWB': 'CLWB instruction',
    'INTEL_PT': 'Intel Processor Trace',
    'AVX512PF': 'AVX-512 Prefetch',
    'AVX512ER': 'AVX-512 Exponential and Reciprocal',
    'AVX512CD': 'AVX-512 Conflict Detection',
    'SHA_NI': 'SHA1/SHA256 Instruction Extensions',
    'AVX512BW': 'AVX-512 BW (Byte/Word granular) Instructions',
    'AVX512VL': 'AVX-512 VL (128/256 Vector Length) Extensions',

    // Extended state features, CPUID level 0x0000000d:1 (EAX), word 10
    'XSAVEOPT': 'XSAVEOPT instruction',
    'XSAVEC': 'XSAVEC instruction',
    'XGETBV1': 'XGETBV with ECX = 1 instruction',
    'XSAVES': 'XSAVES/XRSTORS instructions',
    'XFD': '"" eXtended Feature Disabling',

    // Extended auxiliary flags: Linux defined - for features scattered in various
    // CPUID levels like 0xf, etc.
    // Reuse free bits when adding new feature flags!
    'CQM_LLC': 'LLC QoS if 1',
    'CQM_OCCUP_LLC': 'LLC occupancy monitoring',
    'CQM_MBM_TOTAL': 'LLC Total MBM monitoring',
    'CQM_MBM_LOCAL': 'LLC Local MBM monitoring',
    'FENCE_SWAPGS_USER': '"" LFENCE in user entry SWAPGS path',
    'FENCE_SWAPGS_KERNEL': '"" LFENCE in kernel entry SWAPGS path',
    'SPLIT_LOCK_DETECT': '#AC for split lock',
    'PER_THREAD_MBA': '"" Per-thread Memory Bandwidth Allocation',
    'SGX1': '"" Basic SGX',
    'SGX2': '"" SGX Enclave Dynamic Memory Management (EDMM)',
    'ENTRY_IBPB': '"" Issue an IBPB on kernel entry',
    'RRSBA_CTRL': '"" RET prediction control',
    'RETPOLINE': '"" Generic Retpoline mitigation for Spectre variant 2',
    'RETPOLINE_LFENCE': '"" Use LFENCE for Spectre variant 2',
    'RETHUNK': '"" Use REturn THUNK',
    'UNRET': '"" AMD BTB untrain return',
    'USE_IBPB_FW': '"" Use IBPB during runtime firmware calls',
    'RSB_VMEXIT_LITE': '"" Fill RSB on VM exit when EIBRS is enabled',

    // Intel-defined CPU features, CPUID level 0x00000007:1 (EAX), word 12
    'AVX_VNNI': 'AVX VNNI instructions',
    'AVX512_BF16': 'AVX512 BFLOAT16 instructions',

    // AMD-defined CPU features, CPUID level 0x80000008 (EBX), word 13
    'CLZERO': 'CLZERO instruction',
    'IRPERF': 'Instructions Retired Count',
    'XSAVEERPTR': 'Always save/restore FP error pointers',
    'RDPRU': 'Read processor register at user level',
    'WBNOINVD': 'WBNOINVD instruction',
    'AMD_IBPB': '"" Indirect Branch Prediction Barrier',
    'AMD_IBRS': '"" Indirect Branch Restricted Speculation',
    'AMD_STIBP': '"" Single Thread Indirect Branch Predictors',
    'AMD_STIBP_ALWAYS_ON': '"" Single Thread Indirect Branch Predictors always-on preferred',
    'AMD_PPIN': 'Protected Processor Inventory Number',
    'AMD_SSBD': '"" Speculative Store Bypass Disable',
    'VIRT_SSBD': 'Virtualized Speculative Store Bypass Disable',
    'AMD_SSB_NO': '"" Speculative Store Bypass is fixed in hardware.',
    'CPPC': 'Collaborative Processor Performance Control',
    'BTC_NO': '"" Not vulnerable to Branch Type Confusion',
    'BRS': 'Branch Sampling available',

    // Thermal and Power Management Leaf, CPUID level 0x00000006 (EAX), word 14
    'DTHERM': 'Digital Thermal Sensor',
    'IDA': 'Intel Dynamic Acceleration',
    'ARAT': 'Always Running APIC Timer',
    'PLN': 'Intel Power Limit Notification',
    'PTS': 'Intel Package Thermal Status',
    'HWP': 'Intel Hardware P-states',
    'HWP_NOTIFY': 'HWP Notification',
    'HWP_ACT_WINDOW': 'HWP Activity Window',
    'HWP_EPP': 'HWP Energy Perf. Preference',
    'HWP_PKG_REQ': 'HWP Package Level Request',
    'HFI': 'Hardware Feedback Interface',

    // AMD SVM Feature Identification, CPUID level 0x8000000a (EDX), word 15
    'NPT': 'Nested Page Table support',
    'LBRV': 'LBR Virtualization support',
    'SVML': '"svm_lock" SVM locking MSR',
    'NRIPS': '"nrip_save" SVM next_rip save',
    'TSCRATEMSR': '"tsc_scale" TSC scaling support',
    'VMCBCLEAN': '"vmcb_clean" VMCB clean bits support',
    'FLUSHBYASID': 'flush-by-ASID support',
    'DECODEASSISTS': 'Decode Assists support',
    'PAUSEFILTER': 'filtered pause intercept',
    'PFTHRESHOLD': 'pause filter threshold',
    'AVIC': 'Virtual Interrupt Controller',
    'V_VMSAVE_VMLOAD': 'Virtual VMSAVE VMLOAD',
    'VGIF': 'Virtual GIF',
    'X2AVIC': 'Virtual x2apic',
    'V_SPEC_CTRL': 'Virtual SPEC_CTRL',
    'SVME_ADDR_CHK': '"" SVME addr check',

    // Intel-defined CPU features, CPUID level 0x00000007:0 (ECX), word 16
    'AVX512VBMI': 'AVX512 Vector Bit Manipulation instructions',
    'UMIP': 'User Mode Instruction Protection',
    'PKU': 'Protection Keys for Userspace',
    'OSPKE': 'OS Protection Keys Enable',
    'WAITPKG': 'UMONITOR/UMWAIT/TPAUSE Instructions',
    'AVX512_VBMI2': 'Additional AVX512 Vector Bit Manipulation Instructions',
    'GFNI': 'Galois Field New Instructions',
    'VAES': 'Vector AES',
    'VPCLMULQDQ': 'Carry-Less Multiplication Double Quadword',
    'AVX512_VNNI': 'Vector Neural Network Instructions',
    'AVX512_BITALG': 'Support for VPOPCNT[B,W] and VPSHUF-BITQMB instructions',
    'TME': 'Intel Total Memory Encryption',
    'AVX512_VPOPCNTDQ': 'POPCNT for vectors of DW/QW',
    'LA57': '5-level page tables',
    'RDPID': 'RDPID instruction',
    'BUS_LOCK_DETECT': 'Bus Lock detect',
    'CLDEMOTE': 'CLDEMOTE instruction',
    'MOVDIRI': 'MOVDIRI instruction',
    'MOVDIR64B': 'MOVDIR64B instruction',
    'ENQCMD': 'ENQCMD and ENQCMDS instructions',
    'SGX_LC': 'Software Guard Extensions Launch Control',

    // AMD-defined CPU features, CPUID level 0x80000007 (EBX), word 17
    'OVERFLOW_RECOV': 'MCA overflow recovery support',
    'SUCCOR': 'Uncorrectable error containment and recovery',
    'SMCA': 'Scalable MCA',

    // Intel-defined CPU features, CPUID level 0x00000007:0 (EDX), word 18
    'AVX512_4VNNIW': 'AVX-512 Neural Network Instructions',
    'AVX512_4FMAPS': 'AVX-512 Multiply Accumulation Single precision',
    'FSRM': 'Fast Short Rep Mov',
    'AVX512_VP2INTERSECT': 'AVX-512 Intersect for D/Q',
    'SRBDS_CTRL': '"" SRBDS mitigation MSR available',
    'MD_CLEAR': 'VERW clears CPU buffers',
    'RTM_ALWAYS_ABORT': '"" RTM transaction always aborts',
    'TSX_FORCE_ABORT': '"" TSX_FORCE_ABORT',
    'SERIALIZE': 'SERIALIZE instruction',
    'HYBRID_CPU': '"" This part has CPUs of more than one type',
    'TSXLDTRK': 'TSX Suspend Load Address Tracking',
    'PCONFIG': 'Intel PCONFIG',
    'ARCH_LBR': 'Intel ARCH LBR',
    'IBT': 'Indirect Branch Tracking',
    'AMX_BF16': 'AMX bf16 Support',
    'AVX512_FP16': 'AVX512 FP16',
    'AMX_TILE': 'AMX tile Support',
    'AMX_INT8': 'AMX int8 Support',
    'SPEC_CTRL': '"" Speculation Control (IBRS + IBPB)',
    'INTEL_STIBP': '"" Single Thread Indirect Branch Predictors',
    'FLUSH_L1D': 'Flush L1D cache',
    'ARCH_CAPABILITIES': 'IA32_ARCH_CAPABILITIES MSR (Intel)',
    'CORE_CAPABILITIES': '"" IA32_CORE_CAPABILITIES MSR',
    'SPEC_CTRL_SSBD': '"" Speculative Store Bypass Disable',

    // AMD-defined memory encryption features, CPUID level 0x8000001f (EAX), word 19
    'SME': 'AMD Secure Memory Encryption',
    'SEV': 'AMD Secure Encrypted Virtualization',
    'VM_PAGE_FLUSH': '"" VM Page Flush MSR is supported',
    'SEV_ES': 'AMD Secure Encrypted Virtualization - Encrypted State',
    'V_TSC_AUX': '"" Virtual TSC_AUX',
    'SME_COHERENT': '"" AMD hardware-enforced cache coherency',
  };
}

class FeaturesComponent extends StatefulWidget {

  final Strings _str;
  final PhysicalCPU physicalCPU;

  FeaturesComponent({ super.key, required this.physicalCPU }) :
    _str = ((){
      final String languageCode = Platform.localeName.split('_')[0];

      if(languageCode == 'es') {
        return _SpanishStrings();

      } else if(languageCode == 'eo') {
        return _EsperantoStrings();

      } else {
        return _EnglishStrings();
      }
    })();

  @override
  State<FeaturesComponent> createState() => _FeaturesComponentState();
}

class _FeaturesComponentState extends State<FeaturesComponent> {

  String _search = '';

  @override
  Widget build(BuildContext context) {
    return Container(
        clipBehavior: Clip.hardEdge, // Overflow hidden (for border radius and colored header)
        decoration: BoxDecoration(
          color: (
            (Theme.of(context).brightness == Brightness.light) ?
            Colors.lightBlueAccent.withOpacity(0.2) :
            Colors.greenAccent.withOpacity(0.08)
          ),
          borderRadius: const BorderRadius.all(Radius.circular(9.0)),
          border: Border.all(
            color: (
              (Theme.of(context).brightness == Brightness.light) ?
              Colors.lightBlueAccent.withOpacity(0.8) :
              Colors.greenAccent.withOpacity(0.8)
            ),
            width: 2.0
          )
        ),
        // padding: const EdgeInsets.only(left: 3, right: 3),
        child: Column(
          //crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
              color: (
                (Theme.of(context).brightness == Brightness.light) ?
                Colors.lightBlueAccent.withOpacity(0.8) :
                Colors.greenAccent.withOpacity(0.8)
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    widget._str.cpuFeatures,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black.withOpacity(0.9),
                      fontSize: 17,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ),
            TextField(
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.black.withOpacity(0.2),
                suffixIcon: Icon(
                  Icons.search,
                  color: (Theme.of(context).brightness == Brightness.light) ?
                  Colors.lightBlueAccent.withOpacity(0.8) :
                  Colors.greenAccent.withOpacity(0.8)
                ),
                border: InputBorder.none,
                hintText: widget._str.search,
                contentPadding: const EdgeInsets.only(left: 10.0, top: 15.0)
              ),
              style: const TextStyle(fontSize: 14.0),
              onChanged: (value) {
                setState(() {
                  _search = value;
                });
              },
            ),
            Padding(
              padding: const EdgeInsets.only(left: 3, right: 3),
              child: Table(
                columnWidths: const {
                  0: IntrinsicColumnWidth(),
                  1: IntrinsicColumnWidth(),
                  2: FlexColumnWidth(),
                },
                border: TableBorder(
                  horizontalInside: BorderSide(
                    width: 1,
                    color: (
                      (Theme.of(context).brightness == Brightness.light) ?
                      Colors.lightBlueAccent.withOpacity(0.4) :
                      Colors.greenAccent.withOpacity(0.2)
                    )
                  )
                ),
                children: widget.physicalCPU.features
                  .where((feature) => (_search.isNotEmpty ? feature.contains(_search.toLowerCase()) : true))
                  .map((cpuFeature) => TableRow(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0, bottom: 10.0, left: 10.0, right: 10.0),
                      child: Text(
                        cpuFeature,
                        style: TextStyle(
                          fontWeight: (
                            (Theme.of(context).brightness == Brightness.light) ?
                            FontWeight.bold :
                            FontWeight.normal
                          ),
                          color: (
                            (Theme.of(context).brightness == Brightness.light) ?
                            Colors.black :
                            Colors.white
                          )
                         )
                        )
                      ),
                    const Padding(
                      padding: EdgeInsets.only(top: 10.0),
                      child: Text(':')
                    ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0, bottom: 10.0, left: 10.0, right: 5.0),
                        child: Text(
                          widget._str.cpuFlags.keys.contains(cpuFeature.toUpperCase()) ?
                          widget._str.cpuFlags[cpuFeature.toUpperCase()]! :
                          widget._str.unknown,
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                            color: (
                              (Theme.of(context).brightness == Brightness.light) ?
                              Colors.black :
                              Colors.greenAccent
                            )
                          )
                        )
                      )
                    ]
                  )).toList()
                )
            )
          ],
        )
    );
  }
}