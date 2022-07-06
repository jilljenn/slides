% Coding best practices
% Jill-Jênn Vie
% New in ML workshop
---
institute:
  - \includegraphics[width=3cm]{figures/inria.png}\includegraphics[width=3cm]{figures/soda.png}
biblatexoptions:
  - datamodel=software
  - backend=biber
header-includes:
  - \usepackage{minted}
  - \newsavebox{\mintedbox}
  - \AtEndPreamble{\usepackage{software-biblatex}\ExecuteBibliographyOptions{halid=true,swhid=false,swlabels=true,vcs=true,license=true}}
  - \usepackage{fontspec}
  - |
    ```{=latex}
    \newfontfamily{\Emoji}[Renderer=Harfbuzz]{Noto Color Emoji}
    \def\Clap{{\Emoji 👏}}
    ```
---
# Hi, I'm JJ

- Researcher at Inria Saclay (south of Paris) in AI for education
- I wrote some books about algorithms and a Python package

![](figures/all-books.png)

\centering
\texttt{pip install tryalgo}

# Writing code to oneself \hfill Writing code for someone else

![](figures/code-myself.png)

# A cliché

Quote:\medskip

> Unlike pro developers, researchers code for themselves only.

But at minimum you code for \alert{your future self}.

\footnotesize \raggedleft (for example the version of you who is going to write your PhD thesis)

\normalsize \raggedright
Versioning is a way to keep a backup of your work

\footnotesize \raggedleft
(in case your house burns, for example)

\centering \pause

\includegraphics[width=0.4\linewidth]{figures/git-push.png}

# Minimal requirements

- Committed code should run
- README with "how to use"
- Requirements should be listed \alert{with versions}

\footnotesize \raggedleft
(some times I had to guess the version using binary search)
\normalsize

## If possible

- Examples
- Documentation

# Coding worst practices

- Copy-pasting
- "I don't have time for documentation right now"
- Trusting too much someone else's package

# Writing pretty code {.fragile}

`pycodestyle` follows PEP8 (Style Guide for Python code)

\footnotesize \raggedleft
(also an `--aggressive` mode that will directly fix your code, use with caution)
\normalsize

`pylint` does static analysis: warns you about useless variables, etc.

\vspace{1cm}

Existing equivalents in other languages

# Automatically writing beautiful docs: Sphinx's autodoc {.fragile}

:::::: {.columns}
::: {.column width="65%"}
\tiny
```python
def dijkstra(graph, weight, source=0, target=None):
    """single source shortest paths by Dijkstra
       :param graph: directed graph in listlist or listdict format
       :param weight: in matrix format or same listdict graph
       :assumes: weights are non-negative
       :param source: source vertex
       :type source: int
       :param target: if given, stops once distance to target found
       :type target: int
       :returns: distance table, precedence table
       :complexity: `O(|V| + |E|log|V|)`
    """
    n = len(graph)
    assert all(weight[u][v] >= 0 for u in range(n) for v in graph[u])
    prec = [None] * n
    dist = [float('inf')] * n
    dist[source] = 0
    heap = OurHeap([(dist[node], node) for node in range(n)])
    while heap:
        dist_node, node = heap.pop()       # Closest node from source
        if node == target:
            break
        for neighbor in graph[node]:
            old = dist[neighbor]
            new = dist_node + weight[node][neighbor]
            if new < old:
                dist[neighbor] = new
                prec[neighbor] = node
                heap.update((old, neighbor), (new, neighbor))
    return dist, prec
```
:::
::: {.column width="35%"}
![](figures/tryalgo-doc.png)
:::
::::::

# Writing tests {.fragile}

No need to do it for everything, but some parts of your code.

```shell-session
jj@altaria:~/code/tryalgo$ python -m unittest
......................................................................................................
----------------------------------------------------------------------
Ran 102 tests in 1.185s

OK
```

# What a test looks like {.fragile}

:::::: {.columns}
::: {.column width="60%"}
\tiny
```python
class OurQueue:
    """
    A queue for counting efficiently the number of events
    within time windows.
    Complexity:
        All operators in amortized O(W) time
        where W is the number of windows.
    From JJ's KTM repository: https://github.com/jilljenn/ktm.
    """
    def __init__(self):
        self.queue = []
        self.window_lengths = [
            3600 * 24 * 30, 3600 * 24 * 7, 3600 * 24, 3600]
        self.cursors = [0] * len(self.window_lengths)

    def __len__(self):
        return len(self.queue)

    def get_counters(self, t):
        self.update_cursors(t)
        return [len(self.queue)] + [len(self.queue) - cursor
                                    for cursor in self.cursors]

    def push(self, time):
        self.queue.append(time)

    def update_cursors(self, t):
        for pos, length in enumerate(self.window_lengths):
            while (self.cursors[pos] < len(self.queue) and
                   t - self.queue[self.cursors[pos]] >= length):
                self.cursors[pos] += 1
```
:::
::: {.column width="40%"}
\tiny
```python
import unittest
from utils.this_queue import OurQueue


class TestOurQueue(unittest.TestCase):
    def test_simple(self):
        q = OurQueue()
        q.push(0)
        q.push(0.8 * 3600 * 24)
        q.push(5 * 3600 * 24)
        q.push(40 * 3600 * 24)
        self.assertEqual(
            q.get_counters(40 * 3600 * 24),
            [4, 1, 1, 1, 1])
        
    def test_complex(self):
        q = OurQueue()
        q.push(0)
        q.push(10)
        q.push(3599)
        q.push(3600)
        q.push(3601)
        q.push(3600 * 24)
        q.push(3600 * 24 + 1)
        q.push(3600 * 24 * 7)
        q.push(3600 * 24 * 7 + 1)
        q.push(3600 * 24 * 7 * 30)
        q.push(3600 * 24 * 7 * 30 + 1)
        self.assertEqual(
            q.get_counters(
                3600 * 24 * 7 * 30 + 1),
            [11, 2, 2, 2, 2])
```
:::
::::::

# Continuous integration

![](figures/build-passing.png)

Make sure you don't break the existing version, so that other people software, which relies on yours, won't break.

Ex. Travis, CircleCI, GitHub actions

# argparse {.fragile}

Sometimes on servers you can only run jobs as bash scripts.  
It's good to provide hyper-parameters in the command line.

\begin{lrbox}{\mintedbox}
\RecustomVerbatimEnvironment{Verbatim}{BVerbatim}{}
\begin{minted}{python}
if __name__ == '__main__':
    parser = argparse.ArgumentParser(description='Generates tokens.')
    parser.add_argument('filename', type=str, nargs='?', default='text',
                        help='Try files in demo/ e.g. "demo/text.txt"')
    parser.add_argument('--n', type=int, nargs='?', default=1,
                        help='How many sequences should be printed')
    parser.add_argument('--l', type=int, nargs='?', default=42,
                        help='Length of these sequences')
    args = parser.parse_args()
\end{minted}
\end{lrbox}

\resizebox{\textwidth}{!}{\usebox{\mintedbox}}

\small
```shell-session
(venv) jj@altaria:~/code/markov.py$ python markov.py -h
usage: markov.py [-h] [--n [N]] [--l [L]] [filename]
Generates tokens.
positional arguments:
  filename    Try files in demo/ e.g. "demo/text.txt"
optional arguments:
  -h, --help  show this help message and exit
  --n [N]     How many sequences should be printed
  --l [L]     Length of these sequences
```

# Embed hyper-parameters (argparse) in logs {.fragile}

\scriptsize

```python
saved_results = {
    'options': vars(args),
    'predictions': predictions,
    'results': results,
    'folds': folds
}
with open(os.path.join(folder, 'results-{}.json'.format(iso_date)), 'w') as f:
    json.dump(saved_results, f)
```

\normalsize
Creates `assistments09/results-2022-07-06T23:04:22.json` which contains:

\scriptsize

```json
{
   "options": {"data": "assist09", "n_iter": 20, "d": 5},
   "predictions": [
      {"fold": 0, "pred": [0.6, 0.4], "truth": [1, 0]},
      {"fold": 1, "pred": [0.7, 0.2], "truth": [1, 1]},
   ],
   "results": [
      {"name": "auc", "value": 0.76},
      {"name": "accuracy", "value": 0.82}
   ],
   "folds": "<path-to-fold-file>"
}
```

# A personal suggestion

\setbeamercovered{transparent}

Using `Makefile`

It defines a dependency graph, for example:

\centering
data $\to$ preprocessed data $\to$ \alert<2>{logs} (incl. hyper-parameters) $\to$ \alert<3>{plots}
\raggedright

\vspace{1cm}

\only<1>{Here is the Makefile of my CV:

\includegraphics{figures/makefile-cv.png}}

\only<2->{\uncover<2>{Logging metrics as much as possible (it's OK to log several times at different locations: files, standard output)}

\uncover<3>{Then your plots will only be from your logs; you can only recompute what has changed}}

# Machine-learning specific

## Start small

- Just a few lines of data are enough to test your pipeline
- Try to overfit a single batch

# Feel free to ask questions {.fragile}

You can open issues; \alert<2->{sometimes} researchers are happy to know their code is useful

Do not forget to cite other people's software, e.g. \includegraphics[width=2cm]{figures/sklearn.png}

\small
\fullcite{pedregosa2011scikit}

\fullcite{pandoc2.17}

\pause \pause

```{=latex}
Made using \mintinline{latex}{\usepackage{biblatex-software}}, thanks \raisebox{-8pt}{\includegraphics[width=2cm]{figures/swh.jpg}}
```

# Stuff I didn't cover

`screen` for keeping an interactive session open even while you leave the server.

`tmux` is similar and better: great for pair-programming.

`pdb`, the Python debugger.

`magic-wormhole` for sending (non-sensitive) data over the Internet

`binder`: one-click banner that opens a temporary Jupyter notebook or Lab in the browser with your repo (amazing, Berkeley! \Clap)

`ansible-playbook` for automating a remote install

# Take home message

- Versioning like `git`
- Help others help you    
\hfill (README, `requirements.txt`, doc, examples)
- Start small
- There's nothing worse than making an irreproducible plot

Thanks! Questions?

\raggedleft
`jill-jenn.vie@inria.fr`

<!--

Actually this does not work:
https://tex.stackexchange.com/questions/344202/extra-space-between-command-and-argument-when-using-minted-in-beamer-class

-->
