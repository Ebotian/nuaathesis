# Beamer 编译说明

本目录使用单入口：main.tex -> main.pdf。
推荐引擎：XeLaTeX（中文友好）。

## 1) 依赖
- TeX Live / MacTeX（含 xelatex）
- latexmk
- ctex 宏包

## 2) 常用命令
在 texppt 目录执行：

```bash
# 标准编译（推荐）
latexmk -xelatex main.tex

# 预览模式（文件变化自动重编）
latexmk -pvc -xelatex main.tex

# 清理中间文件（保留 PDF）
latexmk -c

# 彻底清理（含 PDF）
latexmk -C
```

## 3) 故障排查
- 中文字体报错：确认系统中文字体与 ctex 配置可用。
- 找不到 xelatex：检查 TeX 安装路径是否在 PATH 中。
- TikZ 报错：确认 pgf/tikz 组件完整安装。

## 4) 交付建议
- 提交版本：main.tex + main.pdf + outline.md + build.md + latexmkrc
- 评审前检查：
  - PDF 能在现场机器正常打开
  - 页数与讲稿时间匹配
  - 关键公式与图示无溢出
