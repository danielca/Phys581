\NeedsTeXFormat{LaTeX2e}

\ProvidesClass{myarticle}[2014/08/07 Chris Deimert custom LaTeX article document class]

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\ProcessOptions\relax
\LoadClass{article}

% Standard packages to include
\RequirePackage[intlimits]{amsmath}
\RequirePackage{caption}
\RequirePackage[retainorgcmds]{IEEEtrantools}
\RequirePackage[usenames,dvipsnames]{xcolor}
\RequirePackage{verbatim}
\RequirePackage{siunitx}

\setlength{\jot}{8pt}

\RequirePackage{ifpdf}
\ifpdf
\RequirePackage[protrusion=true,expansion=true]{microtype}
    % Gives slightly better typography if using pdflatex
\RequirePackage[pdftex]{graphicx}
\else
\RequirePackage{graphicx}
\fi

%\renewcommand{\labelitemi}{\raise 0.5ex\hbox{\tiny$\bullet$}}
    % Makes bullets smaller in a list

% Fonts
\RequirePackage[scaled]{helvet} % Helvetica font for headings
%\RequirePackage{fouriernc}    % New century schoolbook font
\RequirePackage{fourier}
\RequirePackage[T1]{fontenc}
%\RequirePackage{stix}

% Define myfont (helvetica) for use in titles
\newcommand*{\myfont}{\fontfamily{phv}\selectfont}

% Reformat section headings
\RequirePackage{titlesec}
\titleformat{\section}{\myfont\Large\bfseries}{\thesection}{1em}{}[{\titlerule[0.8pt]}]    % "Large" bold helvetica with underline
\titleformat{\subsection}{\myfont\large\bfseries}{\thesubsection}{1em}{}    % "large" bold helvetica with no underline
\titleformat{\subsubsection}{\myfont\bfseries}{\thesubsubsection}{1em}{}    % regular size bold helvetica with no underline

% Reformat title page
\RequirePackage{titling}
\pretitle{\begin{center}\huge\myfont\bfseries}
\posttitle{\par\end{center}\vskip 1.5em}
\preauthor{\begin{center}
    \large\myfont \lineskip 1.5em%
    \begin{tabular}[t]{c}}
\postauthor{\end{tabular}\par\end{center}}
\predate{\begin{center}\large\myfont}
\postdate{\par\end{center}}

\endinput
