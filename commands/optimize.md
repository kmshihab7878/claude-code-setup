# Performance Optimization

Profile and optimize the specified code or system component.

## Instructions

Use `$ARGUMENTS` to identify the target (file, function, endpoint, or system component).

### Step 1: Profile
- Read the target code thoroughly
- Identify computational complexity (Big-O)
- Look for database queries and their patterns
- Check for I/O operations and their frequency
- Identify memory allocation patterns

### Step 2: Identify Bottlenecks
- N+1 query patterns
- Unnecessary iterations or data copying
- Missing caching opportunities
- Synchronous I/O blocking async paths
- Excessive memory allocation
- Unoptimized algorithms

### Step 3: Optimize
- Apply targeted fixes for each bottleneck
- Prefer algorithmic improvements over micro-optimizations
- Add caching where appropriate (with invalidation strategy)
- Optimize database queries (indexes, joins, projections)

### Step 4: Benchmark
- Show before/after comparison for each optimization
- Quantify improvements where possible
- Document any trade-offs (readability, memory vs speed)

Output:
- Bottleneck analysis with locations
- Optimizations applied with before/after comparisons
- Remaining recommendations prioritized by impact
