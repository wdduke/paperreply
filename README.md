# paperreply

## Copyright Notice

This project is a refactored LaTeX template inspired by an original single-file example identified by the project author as coming from <https://mp.weixin.qq.com/s/acWCLZxFKYH1jrYqK4uD9Q>. The original article, code, and example materials remain the property of their respective author(s) or publisher(s).

The legacy example is kept only as a refactoring case study in `examples/legacy-*`. The default document and the minimal example use newly written fictional review content. Before redistributing, publishing, or using this project in a public or commercial context, replace third-party example text with your own material and make sure you have permission to reuse any third-party content.

## What This Is

`paperreply` is a small XeLaTeX class for writing clean, structured replies to journal referees. It gives you:

- a metadata block for manuscript information;
- a title builder for response letters;
- styled boxes for referee comments and author replies;
- a simple formula box for mathematical explanations;
- small build and cleanup scripts for Windows.

## Project Layout

```text
paperreply/
├── main.tex
├── metadata.tex
├── original-response-content.tex
├── build.bat
├── clean-build.bat
├── latexmkrc
├── LICENSE
├── NOTICE
├── src/
│   ├── paperreply.cls
│   └── paperreply-design.sty
├── examples/
│   ├── minimal.tex
│   ├── legacy-referee1-response.tex
│   ├── legacy-metadata.tex
│   └── legacy-response-content.tex
└── tests/
    └── math-response-test.tex
```

## Quick Start

1. Edit `metadata.tex`.

```tex
\PaperReplySetup{
  response-title = {Response to Referee 1},
  paper-title = {Your Manuscript Title},
  manuscript-id = {JOURNAL-2026-0000},
  authors = {First Author and Second Author}
}
```

2. Edit `original-response-content.tex`.

Write each review point as a section, then put the referee text and your reply into the two semantic environments:

```tex
\section*{Comment 1: Clarify the method}
\begin{refereecomment}
The manuscript should explain how the proposed method is different from existing methods.
\end{refereecomment}

\begin{authorreply}
We thank the referee for this helpful suggestion. We have revised the Introduction to explain the difference more clearly.
\end{authorreply}
```

3. Compile `main.tex` with XeLaTeX.

On Windows, you can run:

```bat
build.bat
```

The PDFs are written to `build/`.

## Writing Formulas

For mathematical replies, use `replyformula` inside an author reply:

```tex
\begin{replyformula}[Error measure]
\[
  E = \frac{1}{n}\sum_{i=1}^{n}\abs{y_i-\hat{y}_i}.
\]
\end{replyformula}
```

The class also provides a few small math helpers:

- `\Expected`, `\Variance`, `\Covariance`, `\Probability`
- `\vect{}`, `\mat{}`
- `\abs{}`, `\norm{}`, `\set{}`
- `\diff`

## Useful Files

- `main.tex`: default entry file.
- `metadata.tex`: manuscript metadata for the default document.
- `original-response-content.tex`: newly written fictional example content.
- `src/paperreply.cls`: class file, metadata interface, title builder, and math helpers.
- `src/paperreply-design.sty`: color system and visual components.
- `examples/minimal.tex`: shortest copyable example.
- `examples/legacy-referee1-response.tex`: legacy refactoring case study based on the third-party source noted above.
- `tests/math-response-test.tex`: formula and math-box smoke test.

## Build And Clean

Build all sample documents:

```bat
build.bat
```

Clean LaTeX intermediate files:

```bat
clean-build.bat
```

If you prefer `latexmk`, this repository includes `latexmkrc`, so this also works from the project root:

```bat
latexmk main.tex
```

## Notes For Reuse

For a real submission, replace the fictional example content with your own review text and replies. Keep the structure simple: one section per comment, one `refereecomment` box, and one `authorreply` box. This makes the final PDF easy for editors and reviewers to scan.
