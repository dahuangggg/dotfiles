local system_java_home = vim.fn.trim(vim.fn.system({ "/usr/libexec/java_home", "-v", "21" }))
local java21_home = nil

for _, candidate in ipairs({
  "/opt/homebrew/opt/openjdk@21/libexec/openjdk.jdk/Contents/Home",
  "/usr/local/opt/openjdk@21/libexec/openjdk.jdk/Contents/Home",
  system_java_home,
}) do
  local java = candidate .. "/bin/java"
  if candidate ~= "" and vim.fn.executable(java) == 1 then
    local version = vim.fn.system({ java, "-version" })
    local major = tonumber(version:match('version "(%d+)'))
    if major and major >= 21 then
      java21_home = candidate
      break
    end
  end
end

if not java21_home then
  vim.notify("JDTLS 需要 Java 21，但当前未找到 Java 21", vim.log.levels.ERROR)
  return {}
end

return {
  cmd = {
    "jdtls",
    "--java-executable",
    java21_home .. "/bin/java",
  },
}
