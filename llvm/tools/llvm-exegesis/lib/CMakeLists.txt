set(TARGETS_TO_APPEND "")

if (LLVM_TARGETS_TO_BUILD MATCHES "X86")
  add_subdirectory(X86)
  set(TARGETS_TO_APPEND "${TARGETS_TO_APPEND} X86")
endif()
if (LLVM_TARGETS_TO_BUILD MATCHES "AArch64")
  add_subdirectory(AArch64)
  set(TARGETS_TO_APPEND "${TARGETS_TO_APPEND} AArch64")
endif()
if (LLVM_TARGETS_TO_BUILD MATCHES "PowerPC")
  add_subdirectory(PowerPC)
  set(TARGETS_TO_APPEND "${TARGETS_TO_APPEND} PowerPC")
endif()

set(LLVM_EXEGESIS_TARGETS "${LLVM_EXEGESIS_TARGETS} ${TARGETS_TO_APPEND}" PARENT_SCOPE)

add_library(LLVMExegesis
  STATIC
  Analysis.cpp
  Assembler.cpp
  BenchmarkResult.cpp
  BenchmarkRunner.cpp
  Clustering.cpp
  CodeTemplate.cpp
  Latency.cpp
  LlvmState.cpp
  MCInstrDescView.cpp
  PerfHelper.cpp
  RegisterAliasing.cpp
  RegisterValue.cpp
  SchedClassResolution.cpp
  SnippetFile.cpp
  SnippetGenerator.cpp
  SnippetRepetitor.cpp
  Target.cpp
  Uops.cpp
  )

llvm_update_compile_flags(LLVMExegesis)
llvm_map_components_to_libnames(libs
  Analysis
  CodeGen
  Core
  ExecutionEngine
  GlobalISel
  MC
  MCDisassembler
  MCJIT
  Object
  ObjectYAML
  Support
  )

if(LLVM_ENABLE_LIBPFM AND HAVE_LIBPFM)
  list(APPEND libs pfm)
endif()

target_link_libraries(LLVMExegesis ${libs})
set_target_properties(LLVMExegesis PROPERTIES FOLDER "Libraries")
