#include <android-base/properties.h>

#include "edify/expr.h"
#include "otautil/error_code.h"

Value *VerifyBootloader(const char *name, State *state,
                        const std::vector<std::unique_ptr<Expr>> &argv) {
  int ret = 0;
  std::string bootloader = android::base::GetProperty("ro.boot.bootloader", "");
  if (bootloader.empty()) {
    return ErrorAbort(state, kFileGetPropFailure,
                      "%s() failed to read current bootloader version", name);
  }

  std::string min_supported_bootloader_arg;
  if (argv.empty() || !Evaluate(state, argv[0], &min_supported_bootloader_arg)) {
    return ErrorAbort(state, kArgsParsingFailure,
                      "%s() error parsing arguments", name);
  }
  int min_supported_bootloader = int(min_supported_bootloader_arg[0]);

  int version = 0;
  if (!bootloader.empty() && bootloader[0] == 'N') {
	ret = 1;
	goto result;
  }
  if (bootloader.length() >= 4)
    version = int(bootloader[bootloader.length() - 4]);

  if (version >= min_supported_bootloader) {
    ret = 1;
  }
result:
  return StringValue(std::to_string(ret));
}

void Register_librecovery_updater_exynos9611() {
  RegisterFunction("exynos1280.verify_bootloader_min", VerifyBootloader);
}
