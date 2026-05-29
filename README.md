# paperreply

## 版权声明

本项目是一个经过重构的 LaTeX 回复审稿意见模板。项目作者说明，旧版单文件示例的来源为：<https://mp.weixin.qq.com/s/acWCLZxFKYH1jrYqK4uD9Q>。原文章、原代码和原示例材料的版权仍归其对应作者或发布方所有。

仓库中的旧示例仅作为重构案例保留在 `examples/legacy-*` 文件中。默认主文档和最小示例均使用本项目新写的虚构审稿意见与回复内容。如果你要公开发布、分发或用于商业场景，请先把第三方示例文本替换为自己的内容，并确认你拥有复用第三方材料的权限。

## 免责声明

本模板只负责提供 LaTeX 排版结构和写作组织方式，不保证论文被接收、修改后录用、审稿人满意或编辑部作出任何特定决定。使用本模板回复审稿意见后，如果论文被拒稿、退修、延迟处理或产生其他投稿结果，本模板作者和维护者不承担任何责任。请根据期刊要求、审稿意见和实际研究内容独立判断如何回复。

## 项目用途

`paperreply` 是一个轻量级 XeLaTeX 文档类，用来写结构清晰、排版整洁的论文审稿回复信。它适合这些场景：

- 回复期刊审稿人意见；
- 回复编辑部意见；
- 按 Reviewer 1、Reviewer 2、Editor 分组组织回复；
- 在回复中标明“已修改”“部分采纳”“未修改”等状态；
- 在回复中标明修改位置；
- 在回复中写少量数学公式；
- 准备匿名或非匿名审稿回复信。

## 项目结构

```text
paperreply/
|-- main.tex
|-- metadata.tex
|-- paperreply.cls
|-- paperreply-design.sty
|-- build.bat
|-- clean-build.bat
|-- latexmkrc
|-- LICENSE
|-- NOTICE
|-- README.md
|-- content/
|   `-- response.tex
|-- src/
|   |-- paperreply.cls
|   `-- paperreply-design.sty
|-- examples/
|   |-- blank-template.tex
|   |-- minimal.tex
|   |-- legacy-referee1-response.tex
|   |-- legacy-metadata.tex
|   `-- legacy-response-content.tex
`-- tests/
    `-- math-response-test.tex
```

日常写作时，通常只需要改两个文件：

- `metadata.tex`：填写稿件题目、稿件编号、作者等信息。
- `content/response.tex`：填写审稿意见和作者回复。

`main.tex` 是主入口，一般不需要改。根目录下的 `paperreply.cls` 和 `paperreply-design.sty` 是转发文件，用来让主文档可以直接写 `\documentclass{paperreply}`。真正的类实现和设计样式放在 `src/` 中。

## 快速开始

### 1. 修改稿件信息

打开 `metadata.tex`，填写你的稿件信息：

```tex
\PaperReplySetup{
  response-title = {Response to Referee 1},
  paper-title = {Your Manuscript Title},
  manuscript-id = {JOURNAL-2026-0000},
  authors = {First Author and Second Author}
}
```

如果你的回复信需要匿名，可以加入：

```tex
anonymous = true
```

完整写法示例：

```tex
\PaperReplySetup{
  response-title = {Response to Referee 1},
  paper-title = {Your Manuscript Title},
  manuscript-id = {JOURNAL-2026-0000},
  authors = {First Author and Second Author},
  anonymous = true
}
```

开启匿名模式后，标题区会把作者显示为 `Anonymous`。

### 2. 修改回复正文

打开 `content/response.tex`，填写审稿意见和作者回复。

推荐的基本结构是：

```tex
\begin{revisionsummary}
\item Clarified the novelty of the method.
\item Added more implementation details.
\item Expanded the limitations section.
\end{revisionsummary}

\reviewersection{Reviewer 1}

\begin{replypoint}[Revised]{Clarify the method}
\begin{refereecomment}
The manuscript should explain how the proposed method is different from existing methods.
\end{refereecomment}

\begin{authorreply}
We thank the referee for this helpful suggestion. We have revised the Introduction to explain the difference more clearly.

\revisionloc{Introduction, final paragraph}
\end{authorreply}
\end{replypoint}
```

这段结构会生成：

- 一个修改摘要框；
- 一个 `Reviewer 1` 分节；
- 一条自动编号的审稿意见；
- 一个审稿意见框；
- 一个作者回复框；
- 一个修改位置标签。

### 3. 编译文档

在 Windows 下，从项目根目录运行：

```bat
build.bat
```

生成的 PDF 会放在 `build/` 文件夹中。

如果你只想编译主文档，也可以用：

```bat
xelatex -output-directory=build main.tex
```

如果你习惯使用 `latexmk`，项目根目录已经提供 `latexmkrc`，可以运行：

```bat
latexmk main.tex
```

### 4. 清理中间文件

LaTeX 会生成 `.aux`、`.log`、`.out` 等中间文件。可以运行：

```bat
clean-build.bat
```

该脚本会清理中间文件，保留生成的 PDF。

## 主要组件

### 修改摘要

用于在回复信开头概括主要修改：

```tex
\begin{revisionsummary}
\item Clarified the novelty of the method.
\item Added implementation details.
\item Added a new limitations paragraph.
\end{revisionsummary}
```

### 多审稿人分节

用于区分不同审稿人或编辑意见：

```tex
\reviewersection{Reviewer 1}
\reviewersection{Reviewer 2}
\reviewersection{Editor}
```

每次使用 `\reviewersection{...}` 后，后续 `replypoint` 会从 `Comment 1` 重新编号。

### 自动编号回复点

推荐每条审稿意见使用一个 `replypoint`：

```tex
\begin{replypoint}[Revised]{Sample size}
...
\end{replypoint}
```

方括号中的内容是状态标签，可以写：

```tex
Revised
Partially revised
Not changed
Clarified
```

大括号中的内容是该条意见的小标题。

### 审稿意见框

用于放审稿人的原文：

```tex
\begin{refereecomment}
Please explain the sampling procedure more clearly.
\end{refereecomment}
```

### 作者回复框

用于放作者的回复：

```tex
\begin{authorreply}
We thank the referee for this suggestion. We have expanded the sampling procedure in Section 2.
\end{authorreply}
```

### 修改位置标签

用于告诉审稿人修改在哪里：

```tex
\revisionloc{Section 2, Page 4, Lines 88--102}
```

建议把它放在 `authorreply` 环境内部。

### 单独使用状态标签

如果不想通过 `replypoint` 添加状态，也可以单独使用：

```tex
\replystatus{Revised}
\replystatus{Partially revised}
\replystatus{Not changed}
```

## 写数学公式

如果回复中需要解释公式，可以在 `authorreply` 里面使用 `replyformula` 环境：

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

## 从空白模板开始

如果你想从一个干净的模板开始，可以复制或参考：

```text
examples/blank-template.tex
```

它包含：

- 元数据设置；
- 修改摘要；
- 一个审稿人分节；
- 一条审稿意见和回复；
- 修改位置标签。

如果你想直接使用项目默认入口，则修改：

```text
metadata.tex
content/response.tex
```

然后运行：

```bat
build.bat
```

## 常用文件说明

- `main.tex`：默认主入口文件。
- `metadata.tex`：默认主文档的稿件元数据。
- `content/response.tex`：默认回复正文文件。
- `paperreply.cls`：根目录转发类文件，让主文档可以直接使用 `\documentclass{paperreply}`。
- `paperreply-design.sty`：根目录转发样式文件，让类文件可以稳定找到设计组件。
- `src/paperreply.cls`：文档类实现，包含元数据接口、标题命令和审稿回复组件。
- `src/paperreply-design.sty`：设计样式文件，包含颜色系统和文本框样式。
- `examples/blank-template.tex`：空白模板，适合新建正式回复信。
- `examples/minimal.tex`：最小示例。
- `examples/legacy-referee1-response.tex`：基于第三方来源的旧示例重构案例。
- `tests/math-response-test.tex`：用于检查公式框、数学命令和匿名模式的测试文档。

## 复用建议

正式投稿时，推荐按以下顺序整理回复信：

1. 先写一段简短感谢语。
2. 用 `revisionsummary` 总结最重要的修改。
3. 用 `reviewersection` 区分 Reviewer 1、Reviewer 2 和 Editor。
4. 每条意见使用一个 `replypoint`。
5. 审稿意见原文放入 `refereecomment`。
6. 作者回复放入 `authorreply`。
7. 如果修改了正文，尽量用 `revisionloc` 标明位置。
8. 如果没有采纳某条建议，建议使用清楚、礼貌、具体的理由说明。

这种结构能让编辑和审稿人更快定位“你改了什么、为什么改、改在哪里”。
