load("@build_bazel_rules_ios//rules:framework.bzl", "apple_framework")

apple_framework(
    name = "SwiftyJSONExt",
    srcs = glob([
        "Sources/**/*.swift",
    ]),
    platforms = {
        "ios": "13.0",
        "macos": "12.0",
    },
    swift_version = "5.9",
    visibility = [
        "//visibility:public",
    ],
    deps = [
        "//internals/Infrastructure",
        "@SwiftyJSON",
    ],
)
