% !TeX encoding = UTF-8
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{paperreply}[2026/05/29 Structured response letter class]

\LoadClass[11pt]{article}

\RequirePackage{iftex}
\ifPDFTeX
  \ClassError{paperreply}{This class is designed for XeLaTeX}{Compile with XeLaTeX.}
\fi

\RequirePackage[a4paper,margin=1in]{geometry}
\RequirePackage{fontspec}
\RequirePackage{amsmath}
\RequirePackage{amssymb}
\RequirePackage{bm}
\RequirePackage{mathtools}
\RequirePackage{microtype}
\RequirePackage{xparse}
\RequirePackage{pgfkeys}
\RequirePackage{paperreply-design}

\newcommand{\paperreply@responseTitle}{Response to Referee}
\newcommand{\paperreply@paperTitle}{}
\newcommand{\paperreply@manuscriptID}{}
\newcommand{\paperreply@authors}{}
\newif\ifpaperreply@anonymous

\pgfkeys{
  /paperreply/.is family,
  /paperreply,
  response-title/.store in=\paperreply@responseTitle,
  paper-title/.store in=\paperreply@paperTitle,
  manuscript-id/.store in=\paperreply@manuscriptID,
  authors/.store in=\paperreply@authors,
  anonymous/.is if=paperreply@anonymous,
  anonymous/.default=true
}

\NewDocumentCommand{\PaperReplySetup}{m}{%
  \pgfkeys{/paperreply,#1}%
}

\NewDocumentCommand{\PaperReplyMakeTitle}{}{%
  \begin{center}
    {\Large\bfseries \paperreply@responseTitle}\\[4pt]
    {\large \textit{\paperreply@paperTitle}}\\[2pt]
    \textbf{Manuscript ID:} \paperreply@manuscriptID\\
    \ifpaperreply@anonymous
      \textbf{Authors:} Anonymous
    \else
      \textbf{Authors:} \paperreply@authors
    \fi
  \end{center}
  \vspace{0.5em}
  \hrule
  \vspace{1em}
}

\newcounter{paperreplypoint}
\NewDocumentCommand{\reviewersection}{m}{%
  \section*{#1}%
  \setcounter{paperreplypoint}{0}%
}

\NewDocumentCommand{\replystatus}{m}{%
  \paperreplystatusbox{\textbf{#1}}%
}

\NewDocumentCommand{\revisionloc}{m}{%
  \par\smallskip
  \paperreplylocbox{\textbf{Revision location:} #1}%
  \par\smallskip
}

\NewDocumentEnvironment{replypoint}{O{} m}{%
  \refstepcounter{paperreplypoint}%
  \section*{Comment \thepaperreplypoint: #2}%
  \begingroup
  \edef\paperreply@status{#1}%
  \ifx\paperreply@status\@empty\else
    \replystatus{#1}\par\smallskip
  \fi
  \endgroup
}{}

\NewDocumentEnvironment{revisionsummary}{}{%
  \begin{paperreplysummarybox}
  \begin{itemize}
}{%
  \end{itemize}
  \end{paperreplysummarybox}
}

\NewDocumentEnvironment{refereecomment}{}{\begin{commentbox}}{\end{commentbox}}
\NewDocumentEnvironment{authorreply}{}{\begin{replybox}}{\end{replybox}}
\NewDocumentEnvironment{replyformula}{O{Formula}}{\begin{paperreplymathbox}[#1]}{\end{paperreplymathbox}}

\DeclareMathOperator{\Expected}{\mathbb{E}}
\DeclareMathOperator{\Variance}{Var}
\DeclareMathOperator{\Covariance}{Cov}
\DeclareMathOperator{\Probability}{Pr}
\newcommand{\vect}[1]{\bm{#1}}
\newcommand{\mat}[1]{\bm{#1}}
\newcommand{\diff}{\mathop{}\!\mathrm{d}}
\newcommand{\abs}[1]{\left\lvert#1\right\rvert}
\newcommand{\norm}[1]{\left\lVert#1\right\rVert}
\newcommand{\set}[1]{\left\{#1\right\}}
