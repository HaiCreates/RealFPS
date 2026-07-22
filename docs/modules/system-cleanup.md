# System Cleanup

> Remove unnecessary temporary files.

## Features

- Temp Files
- Prefetch
- DNS Cache
- Thumbnail Cache
- Recycle Bin
- Microsoft Store Cache

---

## Workflow

```mermaid
flowchart TD

A[Start Cleanup]

A --> B[Temp Files]

A --> C[DNS Cache]

A --> D[Thumbnail Cache]

A --> E[Recycle Bin]

B --> F[Cleanup Complete]

C --> F

D --> F

E --> F
```
