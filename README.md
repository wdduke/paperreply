# paperreply

## 版权声明

本项目是一个经过重构的 LaTeX 回复审稿意见模板。项目作者说明，旧版单文件示例的来源为：<https://mp.weixin.qq.com/s/acWCLZxFKYH1jrYqK4uD9Q>。原文章、原代码和原示例材料的版权仍归其对应作者或发布方所有。

仓库中的旧示例仅作为重构案例保留在 `examples/legacy-*` 文件中。默认主文档和最小示例均使用本项目新写的虚构审稿意见与回复内容。如果你要公开发布、分发或用于商业场景，请先把第三方示例文本替换为自己的内容，并确认你拥有复用第三方材料的权限。

## 免责声明

本模板只负责提供 LaTeX 排版结构和写作组织方式，不保证论文被接收、修改后录用、审稿人满意或编辑部作出任何特定决定。使用本模板回复审稿意见后，如果论文被拒稿、退修、延迟处理或产生其他投稿结果，本模板作者和维护者不承担任何责任。请根据期刊要求、审稿意见和实际研究内容独立判断如何回复。

## 项目用途

`paperreply` 是一个轻量级 XeLaTeX 文档类，用来写结构清晰、排版整洁的论文审稿回复信。它提供：

- 用于填写稿件信息的元数据接口；
- 自动生成回复信标题区的命令；
- 区分审稿人意见和作者回复的彩色文本框；
- 用于解释数学公式的公式框；
- Windows 下可直接运行的构建和清理脚本。

## 项目结构

```text
paperreply/
|-- main.tex
|-- metadata.tex
|-- original-response-content.tex
|-- paperreply.cls
|-- paperreply-design.sty
|-- build.bat
|-- clean-build.bat
|-- latexmkrc
|-- LICENSE
|-- NOTICE
|-- README.md
|-- src/
|   |-- paperreply.cls
|   `-- paperreply-design.sty
|-- examples/
|   |-- minimal.tex
|   |-- legacy-referee1-response.tex
|   |-- legacy-metadata.tex
|   `-- legacy-response-content.tex
`-- tests/
    `-- math-response-test.tex
```

根目录下的 `paperreply.cls` 和 `paperreply-design.sty` 是很薄的转发文件，用来让主文档可以直接写 `\documentclass{paperreply}`。真正的类实现和设计样式仍然集中在 `src/` 中。

## 快速上手

第一步，修改 `metadata.tex`，填写你的稿件信息。

```tex
\PaperReplySetup{
  response-title = {Response to Referee 1},
  paper-title = {Your Manuscript Title},
  manuscript-id = {JOURNAL-2026-0000},
  authors = {First Author and Second Author}
}
```

第二步，修改 `original-response-content.tex`，填写审稿意见和作者回复。

建议每一条审稿意见使用一个 `\section*{...}`。审稿人的原始意见放在 `refereecomment` 环境中，作者回复放在 `authorreply` 环境中。

```tex
\section*{Comment 1: Clarify the method}
\begin{refereecomment}
The manuscript should explain how the proposed method is different from existing methods.
\end{refereecomment}

\begin{authorreply}
We thank the referee for this helpful suggestion. We have revised the Introduction to explain the difference more clearly.
\end{authorreply}
```

第三步，编译 `main.tex`。

在 Windows 下，可以直接运行：

```bat
build.bat
```

生成的 PDF 会放在 `build/` 文件夹中。

## 写数学公式

如果回复中需要解释公式，可以在 `authorreply` 里面使用 `replyformula` 环境。

```tex
\begin{replyformula}[Error measure]
\[
  E = \frac{1}{n}\sum_{i=1}^{n}\abs{y_i-\hat{y}_i}.
\]
\end{replyformula}
```

文档类还提供了一些常用数学命令：

- `\Expected`、`\Variance`、`\Covariance`、`\Probability`
- `\vect{}`、`\mat{}`
- `\abs{}`、`\norm{}`、`\set{}`
- `\diff`

## 常用文件说明

- `main.tex`：默认主入口文件。
- `metadata.tex`：默认主文档的稿件元数据。
- `original-response-content.tex`：本项目新写的虚构审稿回复示例。
- `paperreply.cls`：根目录转发类文件，让主文档可以直接使用 `\documentclass{paperreply}`。
- `paperreply-design.sty`：根目录转发样式文件，让类文件可以稳定找到设计组件。
- `src/paperreply.cls`：文档类实现，包含元数据接口、标题命令和数学辅助命令。
- `src/paperreply-design.sty`：设计样式文件，包含颜色系统和文本框样式。
- `examples/minimal.tex`：最小可复制示例，适合新建自己的回复信时参考。
- `examples/legacy-referee1-response.tex`：基于第三方来源的旧示例重构案例。
- `tests/math-response-test.tex`：用于检查公式框和数学命令的测试文档。

## 构建与清理

构建所有示例文档：

```bat
build.bat
```

清理 LaTeX 编译中间文件：

```bat
clean-build.bat
```

如果你习惯使用 `latexmk`，项目根目录已经提供 `latexmkrc`，也可以运行：

```bat
latexmk main.tex
```

## 复用建议

正式投稿时，请把示例内容替换为自己的审稿意见和回复。推荐保持简单结构：每条意见一个小节，每条意见对应一个 `refereecomment` 框和一个 `authorreply` 框。这样编辑和审稿人阅读 PDF 时会更容易定位修改点。
