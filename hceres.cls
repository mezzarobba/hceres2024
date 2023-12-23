\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{hceres}

\LoadClass[9pt]{extbook}

\RequirePackage{etoolbox}
\RequirePackage{polyglossia}
\RequirePackage{hyperref}
\RequirePackage{graphicx}
\RequirePackage{longtable}
\RequirePackage{soul}
\RequirePackage{jobname-suffix}
\RequirePackage{environ}

%%% Fonts

\RequirePackage{microtype}

\RequirePackage{fontspec}
% \setmainfont{Century Gothic}
\setmainfont{URW Gothic}

%%% Colors

\RequirePackage[table]{xcolor}
\definecolor{hceresred}{HTML}{ED145B}
\definecolor{hcerespurple}{HTML}{5C2D91}
\definecolor{hceresgreen}{HTML}{76923C}

%%% Tikz

\RequirePackage{tikz}
\usetikzlibrary{positioning}

%%% Page layout

\RequirePackage{geometry}
\geometry{
  a4paper,
  includeheadfoot,
  hmargin=2cm,
  top=0.2cm,
  bottom=1cm,
  headheight=1.2cm,
  headsep=1cm
}

\RequirePackage{emptypage}

\RequirePackage{fancyhdr}
\pagestyle{fancy}
\newcommand{\headerfont}{\fontsize{7}{7}\selectfont}
\fancyhead[L]{\headerfont{}Self-Evaluation Document for Research Units}
\fancyhead[R]{
  \makebox[0pt]{\smash{\raisebox{-31pt}{%
    \includegraphics[height=2.4cm]{assets/logo-hceres-new-en-couleur-transparent.png}}%
  }}}
\fancyfoot[L]{%
  \headerfont{}%
  2024--2025 Evaluation campaign -- Group~E\hfill
  Research Evaluation Department\hfill
}
\fancyfoot[C]{}
\fancyfoot[R]{\headerfont{}\thepage}
\renewcommand{\headrulewidth}{0pt}
\renewcommand{\footrulewidth}{0pt}

\RequirePackage{booktabs}

\RequirePackage[skip=1ex,indent=0pt]{parskip}

%%% Section headings and numbering

\RequirePackage{titlesec}

\titleformat{\part}[block]%
  {\filcenter\fontsize{26}{30}\selectfont\color{hcerespurple}\bfseries}%
  {\thepart}{1em}{}

\titleformat{\chapter}[hang]%
  {\fontsize{26}{30}\selectfont\color{hcerespurple}\bfseries}%
  {\thechapter}{1em}{}
\@addtoreset{chapter}{part}

\titleformat{\section}[hang]%
  {\fontsize{16}{20}\selectfont\color{hceresred}\MakeUppercase}%
  {\thesection-}{1ex}{}
\titlespacing{\section}{0pt}{*2}{*2}
\renewcommand{\thesection}{\arabic{section}}

\titleclass{\team}{straight}[\section]
\titleformat{\team}[hang]%
  {\fontsize{12}{14}\selectfont\color{hcerespurple}\bfseries}%
  {\thesection-\theteam}{1ex}{}
\titlespacing{\team}{0pt}{*2}{*2}
\newcounter{team}
\renewcommand{\theteam}{\arabic{team}}

\titleformat{\subsection}[hang]%
  {\fontsize{12}{14}\selectfont\color{hcerespurple}\bfseries}%
  {\thesubsection-}{1ex}{}
\titlespacing{\subsection}{0pt}{*2}{*2}
\renewcommand{\thesubsection}{\arabic{subsection}}

\titleformat{\subsubsection}[hang]%
  {\fontsize{10}{12}\selectfont\color{hcerespurple}}%
  {\thesubsubsection}{1ex}{}
\titlespacing{\subsubsection}{0pt}{*2}{*2}

%% Tile page

\renewcommand{\maketitle}{
  \begin{titlepage}
    \begin{tikzpicture}[remember picture,overlay]
      \node (logo) [anchor=north west] at (current page.north west) {
        \includegraphics[width=4cm]{assets/logo-hceres-new-en-couleur-transparent.png}
      };
      \node (bg) [anchor=south east] at (current page.south east) {
        \includegraphics[width=16.2cm]{assets/front-page-background.jpg}
      };
      \node [right=1cm of logo] {
        \fontsize{11}{13}%
        \selectfont%
        \color{hceresred}%
        \bfseries%
        Department of Research Evaluation
      };
      \node [below=1cm,
        anchor=north west,
        text width=14.75cm,
        inner sep=0.5cm]
      at (bg.north west) {%
        \fontsize{26}{30}%
        \selectfont%
        \color{hcerespurple}%
        RESEARCH UNIT SELF-ASSESSMENT DOCUMENT \\[2cm]
        \@title \\[2cm]
        \fontsize{16}{19}%
        \selectfont%
        \color{hceresred}%
        \textbf{--}\\
        \textbf{2024-2025 EVALUATION CAMPAIGN}\\
        GROUP E\\[3cm]
        \fontsize{11}{13}%
        \selectfont%
        \color{hcerespurple}%
        \textbf{\@date}
      };
    \end{tikzpicture}
  \end{titlepage}
}

%%% Table of contents

\setcounter{tocdepth}{0}

%%% References

\RequirePackage[defernumbers=true,language=english]{biblatex}
\newcommand{\printteambibliography}{%
  \printbibliography[heading=subbibliography,segment=\therefsegment]
}

%%% Instructions

\newtoggle{instructions}
\settoggle{instructions}{true}

\NewEnviron{hceresinstructions}{%
  \iftoggle{instructions}{%
    \color{hceresgreen}\BODY%
  }{}
}
\NewEnviron{extrainstructions}{%
  \iftoggle{instructions}{%
    \colorbox{yellow!50}{%
      \begin{minipage}{.98\textwidth}
        \BODY%
      \end{minipage}%
    }%
  }{}
}
\NewEnviron{draft}{%
  \iftoggle{instructions}{%
    \colorbox{red!50}{%
      \begin{minipage}{.98\textwidth}
        \BODY%
      \end{minipage}%
    }%
  }{}
}

\newcommand{\pagebudget}[1]{%
  \iftoggle{instructions}{%
    \ifhmode\quad\fi%
    \smash{\colorbox{red!50}{\color{black}\normalfont\normalsize #1}}%
  }{}
}

%%% Misc custom commands and environments

\newcommand{\activityprofile}[8][]{%
  \extrarowheight=\aboverulesep%
  \addtolength{\extrarowheight}{\belowrulesep}
  \aboverulesep=0pt
  \belowrulesep=0pt
  \begin{longtable}{m{13.15cm}w{c}{3cm}}
    \toprule
    \rowcolor{lightgray}
    \textbf{Activities} (Distribute 100 points on these 7 items) & \\
    \midrule
    \textbf{Contribution to innovative teaching based on research}
      (University Research Schools - EUR, structuring training through
      research - SFRI, etc.)
    & #2 \\
    \midrule
    \textbf{Research administration} (responsibility for steering research
      (VP, Institute Management, Scientific Director, etc.), participation in
      evaluation systems (CNU, CoNRS, CSS, etc.), responsibility for IdEx,
      project management (ANR, Horizon Europe, ERC, CPER State-Region
      contract, France 2030, etc.), editorial responsibilities in national or
      international journals or collections.
    & #3 \\
    \midrule
    \textbf{Research dissemination} (sharing knowledge with the general
      public, scientific outreach, interface between science/society)
    & #4 \\
    \midrule
    \textbf{Research and research supervision} (involvement in supervision
      at doctoral level and post-doctoral level)
    & #5 \\
    \midrule
    \textbf{Technical expertise} (for national and regional public
      authorities, businesses, international bodies (UN, FAO, WHO, etc.)
    & #6 \\
    \midrule
    \textbf{Valorisation, transfer, innovation}
    & #7 \\
    \midrule
    \textbf{Other activities.}
    #1
    & #8 \\
    \bottomrule
  \end{longtable}
}
