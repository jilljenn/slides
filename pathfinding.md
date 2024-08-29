% Pathfinding
% JJV
% 30 août 2024
---
aspectratio: 169
header-includes:
  - \def\hfilll{\hspace{0pt plus 1 filll}}
---

# DFS: depth-first search in Python \hfill In your C++ notebook

:::::: {.columns}
::: {.column}
```python
def dfs(graph, u, visited):
    visited[u] = True
    for v in graph[u]:
        if not visited[u]:
            dfs(graph, v, visited)
```
:::
::: {.column}
```cpp
vector<int> vs[N];
int visited[N];

void dfs(int u) {
        if (visited[u] == 1)
                /*...*/;
        else if (visited[u] == 2)
                /*...*/;
        else {
                visited[u] = 1;
                for (int v : vs[u])
                        dfs(v);
                visited[u] = 2;
        }
}
```
:::
::::::

# Pathfinding in graphs

```
todo = SomeDataStructure()
Put start in todo
While todo is not empty
	Get node from todo
	For each neighbor of node
		Add neighbor to todo if not visited yet
```

According to the data structure, the complexity and algorithm can be different

- Stack $\to$ what?
- Queue $\to$ what?
- Heap $\to$ what?
- ? $\to$ graph with edges 0 and 1

Actually, when we mark nodes can have an impact on the complexity too

# DFS: depth-first search

```python
def dfs_recursive(graph, node, seen):
    seen[node] = True
    for neighbor in graph[node]:
        if not seen[neighbor]:
            dfs_recursive(graph, neighbor, seen)
```

\pause

```python
def dfs_iterative(graph, start, seen):
    seen[start] = True
    to_visit = [start]
    while to_visit:
        node = to_visit.pop()
        for neighbor in graph[node]:
            if not seen[neighbor]:
                seen[neighbor] = True
                to_visit.append(neighbor)
```

# DFS

\centering

![](figures/stack-traversal.png){width=90%}

# DFS \hfill \quad DFS tree traversal

:::::: {.columns}
::: {.column}
```cpp
vector<int> vs[N];
int visited[N];

void dfs(int u) {
        if (visited[u] == 1)
                /*...*/;
        else if (visited[u] == 2)
                /*...*/;
        else {
                visited[u] = 1;
                for (int v : vs[u])
                        dfs(v);
                visited[u] = 2;
        }
}
```
:::
::: {.column}
![](figures/dfs-order.png)

\textcolor{red}{Pre-order: F B A D C E G I H}  
\textcolor{green!50!black}{In-order: A B C D E F G H I} (binary tree)  
\textcolor{blue}{Post-order: A C E D B H I G F}

\centering

\textcolor{gray}{(Wikipedia)}
:::
::::::

# Floyd-Warshall: all source--destination pairs

```cpp
void floydwarshall(vector<vector<int>>& d) {
        // d[u][v] = c(u, v) si (u, v) arc et +oo sinon                         
        int n = d.size();
        for (int w = 0; w < n; w++)
                for (int u = 0; u < n; u++)
                        for (int v = 0; v < n; v++)
                                d[u][v] = min(d[u][v], d[u][w] + d[w][v]);
}
```

$d_k[u][v] =$ shortest length between $u$ and $v$ using only nodes $< k$

$$d(u, v) = \min_w d(u, w) + d(w, v)$$

# Distributivity in semirings (thanks Bellman)

$$ \begin{array}{lccl}
\textnormal{Matrix multiplication} & \displaystyle \sum_k a_{ik} b_{kj} & (+, \times) & \textnormal{(Binet, 1812)}\\
\textnormal{Shortest path} & \displaystyle \min_k d_{ik} + d_{kj} & (\min, +) & \textnormal{(Bellman, 1958)}\\
\textnormal{Most probable path} & \displaystyle \max_k p_{ik} p_{kj} & (\max, \times) & \textnormal{(Viterbi, 1967)}
\end{array} $$

# Bellman-Ford

:::::: {.columns}
::: {.column}
\footnotesize

```cpp
const int oo = 1e9;
int n, m;
int dist[N];
vector<tuple<int, int, int>> edge;

bool bellmanford (int u0) {
        fill_n (dist, n, +oo);
        dist[u0] = 0;
        bool stable = false;
        for (int t = 0; t < n && !stable; t++) {
                stable = true;
                for (auto[u, v, c] : edge) if (dist[u] < +oo && dist[u] + c < dist[v]) {
                        dist[v] = dist[u] + c;
                        stable = false;
                }
        }
        return stable;
}
```
:::
::: {.column}
Repeat at most $|V|$ times  
\quad For each edge $(u, v) \in E$  
\quad \quad $d(v) = \min(d(v), d(u) + w_{uv})$
:::
::::::

$d_k[v] =$ shortest length from source to $v$ using at most $k$ edges

# Dijkstra's algorithm

\small

```cpp
const int oo = 1e9;
int n, m;
vector<pair<int, int>> vs[N];
int dist[N];
fill_n(dist, N, oo);

void dijkstra(int u0) {
        priority_queue<pair<int, int>> q;
        q.emplace(-0, u0);
        while (!q.empty()) {
                auto [d, u] = q.top();
                q.pop();
                if (dist[u] == +oo) {
                        dist[u] = -d;
                        for (auto [v, c] : vs[u])
                                q.emplace(d - c, v);
                }
        }
}
```

# Summary: shortest paths

\centering

![](figures/pathfinding.png){width=95%}
