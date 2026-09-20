# Funnel Drop-off & Cart Abandonment Analysis
### Why does an e-commerce platform with 5 lakh visitors/month earn only 7 Cr?
> Built end-to-end using MySQL · Python · Power BI
> Synthetic dataset · 500K sessions · 4 tables · Real-world analyst workflow
---
## The Problem
Half a million users visit this platform every month. Only 5.92% of them buy something.
The rest — 94 out of 100 — leave. That's not a traffic problem. That's a conversion problem.
This project answers three questions leadership actually asks:
1. Where exactly in the funnel are users dropping off?
2. Is the drop-off device/channel/time specific — or universal?
3. What is the  value of fixing the top 2 problems?
---
## What I Found
| Finding | Detail | Business Impact |
|---|---|---|
| PDP → Cart is the biggest leak | 2,13,697 sessions/month lost here | Trust/UX issue on
product pages |
| Mobile checkout is broken | 8.4pp lower CVR vs desktop at ATC→Checkout | Not intent — pure UX
friction |
| Paid Ads bring the wrong traffic | CVR 4.2% vs Organic 6.6% | 57 less GMV per session |
| Evening converts 35-55% better | 7.7–8.0% CVR at 18–22hrs vs 5.3% afternoon | Timing
campaigns wrong |
| 1.94 Cr sitting in abandoned carts | 73.4% abandonment, 81,756 sessions/month | 10% recovery
= 1.94 Cr/mo |
---
## Tech Stack
| Layer | Tool | What I did |
|---|---|---|
| Data | MySQL 8.0 | 10 queries: funnel flags VIEW, window functions, CTEs |
| Analysis | Python (pandas, SQLAlchemy) | Cohort analysis, correlation matrix |
| Visualisation | Plotly, seaborn, matplotlib | Funnel chart, boxplot, heatmap |
| Dashboard | Power BI | 4 pages, slicers, DAX measures, GMV simulator |
---
## Dashboard Preview
![Dashboard](outputs/dashboard/dashboard.png)
> The GMV Recovery Simulator (bottom row) lets you drag a slider from 0–20%
> and watch the  Crore card update in real time. Built using DAX What-If Parameters.
---
## Key Learnings
- `MAX(CASE WHEN ...)` is the correct SQL pattern for multi-row-to-single-row funnel flags
- `pct_change()` in pandas gives negative CVR% — wrong. Use `current/previous * 100`
- LEFT JOIN (not INNER JOIN) when starting from sessions — or you silently drop 94% of data
- Session duration has near-zero correlation with conversion (r=0.016) — long sessions =friction
- Mobile drop-off is at ATC→Checkout, not PDP→ATC — proving it is UX, not intent
---
## If This Were Real Data
1. Filter bot traffic and sessions < 5 seconds before any analysis
2. Electronics AOV would be 8-10x Fashion — category recovery sizing changes completely
3. A/B test: simplified mobile checkout vs current — measure ATC→Checkout improvement
4. Build the logistic regression model to score each active cart session by abandonment risk
5. Connect to live MySQL for automated daily funnel refresh in Power BI
---
## Project Structure
```
ecommerce-funnel-analysis/
 data/ Schema + sample CSVs
 sql/ 10 queries (numbered, sequential)
 python/ 6 analysis scripts + requirements.txt
 powerbi/ Dashboard PDF + .pbix
 outputs/ Charts, screenshots
 docs/ SQL and Python documentation PDFs
```
---
*Made by Deepak | [LinkedIn](www.linkedin.com/in/deepak1114)*
