% Intro Options
\ProvidesClass{deedy-resume-reversed}[2018/09/22 CV class]
\NeedsTeXFormat{LaTeX2e}
\DeclareOption{print}{\def\@cv@print{}}
\DeclareOption*{%
  \PassOptionsToClass{\CurrentOption}{article}
}
\ProcessOptions\relax
\LoadClass{article}

% Package Imports
\usepackage[hmargin=1.25cm, vmargin=0.75cm]{geometry}
\usepackage[hidelinks]{hyperref}

% Publications
\usepackage{cite}
\renewcommand\refname{\vskip -1.5cm}

% Color definitions
\usepackage[usenames,dvipsnames]{xcolor}
\definecolor{date}{HTML}{666666}
\definecolor{primary}{HTML}{2b2b2b}
\definecolor{headings}{HTML}{6A6A6A}
\definecolor{subheadings}{HTML}{333333}

% Set main fonts - Using system fonts available on macOS
\usepackage{fontspec}
% Try to use Lato if available, fallback to Helvetica Neue
\IfFontExistsTF{Lato}
  {\setmainfont[Color=primary]{Lato}}
  {\setmainfont[Color=primary]{Helvetica Neue}}

% Try to use Raleway if available, fallback to Helvetica Neue Light
\IfFontExistsTF{Raleway}
  {\setsansfont[Scale=MatchLowercase,Mapping=tex-text]{Raleway}}
  {\setsansfont[Scale=MatchLowercase,Mapping=tex-text]{Helvetica Neue}}

% Date command
\usepackage[absolute]{textpos}
\usepackage[UKenglish]{isodate}
\setlength{\TPHorizModule}{1mm}
\setlength{\TPVertModule}{1mm}
\newcommand{\lastupdated}{\begin{textblock}{60}(155,5)
\color{date}\sffamily\fontsize{8pt}{10pt}\selectfont
Last Updated on \today
\end{textblock}}

% Name command
\newcommand{\namesection}[2]{
\centering{
\fontsize{40pt}{60pt}
\sffamily\selectfont #1
} \\[5pt]
\centering{
\color{headings}
\sffamily\fontsize{11pt}{14pt}\selectfont #2}
\noindent\makebox[\linewidth]{\color{headings}\rule{\paperwidth}{0.4pt}}
\vspace{-15pt}
}

% Section seperators
\usepackage{titlesec}
\titlespacing{\section}{0pt}{0pt}{0pt}
\titlespacing{\subsection}{0pt}{0pt}{0pt}
\newcommand{\sectionsep}{\vspace{8pt}}

% Headings command
\titleformat{\section}{\color{headings}
\scshape\sffamily\fontsize{16pt}{24pt}\selectfont \raggedright\uppercase}{}{0em}{}

% Subeadings command
\titleformat{\subsection}{
\color{subheadings}\sffamily\fontsize{12pt}{12pt}\selectfont\bfseries\uppercase}{}{0em}{}

\newcommand{\runsubsection}[1]{
\color{subheadings}\sffamily\fontsize{12pt}{12pt}\selectfont\bfseries\uppercase {#1} \normalfont}

% Descriptors command
\newcommand{\descript}[1]{
\color{subheadings}\raggedright\scshape\sffamily\fontsize{11pt}{13pt}\selectfont {#1 \\} \normalfont}

% Location command
\newcommand{\location}[1]{
\color{subheadings}\raggedright\sffamily\fontsize{10pt}{12pt}\selectfont {#1\\} \normalfont}

% Bullet Lists with fewer gaps command
\newenvironment{tightemize}{
\vspace{-\topsep}\begin{itemize}\itemsep1pt \parskip0pt \parsep0pt}
{\end{itemize}\vspace{-\topsep}}

