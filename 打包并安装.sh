#!/bin/bash

# 本机打包 + 安装 helper（无需开发者签名）

set -euo pipefail

echo "🚀 AuraWind 本机打包并安装"
echo "==========================="
echo ""

if [ "${EUID}" -eq 0 ]; then
    echo "❌ 请不要用 sudo 直接运行整个脚本。"
    echo "   这个脚本会在最后只对安装步骤请求管理员权限。"
    exit 1
fi

PROJECT_DIR="$(cd "$(dirname "$0")" && pwd)"
DERIVED_DATA_PATH="${TMPDIR:-/tmp}/AuraWindDD"
BUILD_DIR="${DERIVED_DATA_PATH}/Build/Products/Release"
APP_PATH="${BUILD_DIR}/AuraWind.app"
HELPER_TOOL="${BUILD_DIR}/com.aurawind.AuraWind.SMCHelper"
HELPER_DIR="${APP_PATH}/Contents/Library/LaunchServices"
DESKTOP_APP="${HOME}/Desktop/AuraWind.app"

HELPER_INSTALL_PATH="/Library/PrivilegedHelperTools/com.aurawind.AuraWind.SMCHelper"
LAUNCHD_PLIST_PATH="/Library/LaunchDaemons/com.aurawind.AuraWind.SMCHelper.plist"
LAUNCHD_LABEL="com.aurawind.AuraWind.SMCHelper"

cd "${PROJECT_DIR}"

echo "1️⃣ 清理并编译..."
rm -rf "${DERIVED_DATA_PATH}"
xcodebuild -project AuraWind.xcodeproj \
  -scheme AuraWind \
  -configuration Release \
  -derivedDataPath "${DERIVED_DATA_PATH}" \
  clean build | tail -n 40

if [ ! -f "${HELPER_TOOL}" ] || [ ! -d "${APP_PATH}" ]; then
    echo "❌ 编译产物不完整，缺少 app 或 helper"
    exit 1
fi
echo "   ✅ 编译成功"

echo "2️⃣ 将 Helper Tool 打包到应用内部..."
mkdir -p "${HELPER_DIR}"
cp -f "${HELPER_TOOL}" "${HELPER_DIR}/"
chmod 755 "${HELPER_DIR}/com.aurawind.AuraWind.SMCHelper"
echo "   ✅ 已嵌入 ${HELPER_DIR}"

echo "3️⃣ 重新 ad-hoc 签名应用..."
codesign --force --deep --sign - "${APP_PATH}"
echo "   ✅ 签名完成"

echo "4️⃣ 复制应用到桌面..."
rm -rf "${DESKTOP_APP}"
cp -R "${APP_PATH}" "${DESKTOP_APP}"
echo "   ✅ ${DESKTOP_APP}"

echo "5️⃣ 安装 Helper Tool 到系统目录（需要管理员密码）..."
sudo /usr/bin/true

sudo launchctl bootout system "${LAUNCHD_PLIST_PATH}" 2>/dev/null || true
sudo pkill -9 -f "${LAUNCHD_LABEL}" 2>/dev/null || true

sudo install -o root -g wheel -m 755 "${HELPER_DIR}/com.aurawind.AuraWind.SMCHelper" "${HELPER_INSTALL_PATH}"
sudo install -o root -g wheel -m 644 "${PROJECT_DIR}/SMCHelper/Launchd.plist" "${LAUNCHD_PLIST_PATH}"

sudo launchctl bootstrap system "${LAUNCHD_PLIST_PATH}" 2>/dev/null || sudo launchctl load "${LAUNCHD_PLIST_PATH}"
sudo launchctl kickstart -k "system/${LAUNCHD_LABEL}" 2>/dev/null || true

echo ""
echo "✅ 安装完成"
echo "📋 验证:"
echo "   Helper: $(ls -lh "${HELPER_INSTALL_PATH}" 2>/dev/null || echo '未安装')"
echo "   Service: $(launchctl print "system/${LAUNCHD_LABEL}" 2>/dev/null | rg '^\\s*state = ' | sed 's/^\\s*//' || echo '未运行')"
echo ""
echo "🚀 现在可以启动桌面的 AuraWind.app 进行本机使用。"
