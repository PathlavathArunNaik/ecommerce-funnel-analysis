# 🛒 E-commerce Funnel & Cart Abandonment Analysis

### Why does an e-commerce platform with **500K monthly visitors** generate only **₹7 Cr in revenue?**

An end-to-end **E-commerce Funnel & Cart Abandonment Analysis** project built using **MySQL, Python, and Power BI**. The project analyzes 500K synthetic customer sessions to identify funnel drop-offs, conversion problems, device/channel performance, and opportunities for GMV recovery.

---

## 📌 Project Overview

The objective of this project is to understand **where customers drop out of the e-commerce journey and why**, and to quantify the potential business impact of improving the major problem areas.

### Key Business Questions

1. Where exactly are customers dropping off in the purchase funnel?
2. Are conversion problems related to **device, marketing channel, or time of day**?
3. What is the potential revenue impact of improving the biggest conversion problems?
4. How much revenue could potentially be recovered from abandoned carts?

---

## 📊 Key Findings

| Finding                            | Insight                                                            | Business Impact                                    |
| ---------------------------------- | ------------------------------------------------------------------ | -------------------------------------------------- |
| 🛍️ PDP → Cart is the biggest leak | **213,697 sessions/month** lost                                    | Indicates potential product-page UX/trust issues   |
| 📱 Mobile checkout friction        | **8.4 percentage points lower CVR** than desktop at ATC → Checkout | Indicates potential mobile UX problems             |
| 📢 Paid Ads underperform           | **4.2% CVR** vs **6.6% Organic**                                   | Paid traffic has lower conversion efficiency       |
| 🌙 Evening performs better         | **7.7–8.0% CVR** during 18–22 hrs vs 5.3% afternoon                | Opportunity for campaign timing optimisation       |
| 🛒 Cart abandonment                | **73.4% abandonment rate**                                         | Significant potential revenue recovery opportunity |

---

## 🛠️ Tech Stack

| Technology     | Purpose                                                 |
| -------------- | ------------------------------------------------------- |
| **MySQL 8.0**  | Data querying, funnel analysis, CTEs & window functions |
| **Python**     | Data analysis and exploratory analysis                  |
| **Pandas**     | Data cleaning and transformation                        |
| **SQLAlchemy** | Database connectivity                                   |
| **Matplotlib** | Data visualization                                      |
| **Seaborn**    | Statistical visualization                               |
| **Plotly**     | Interactive visualizations                              |
| **Power BI**   | Interactive dashboard and business reporting            |
| **DAX**        | Measures and GMV recovery simulation                    |

---

## 🔄 Project Workflow

```text
Raw E-commerce Data
        ↓
MySQL Database
        ↓
SQL Data Analysis
        ↓
Python Data Analysis
        ↓
Funnel & Conversion Analysis
        ↓
Power BI Dashboard
        ↓
Business Insights
        ↓
Revenue Recovery Opportunities
```

---

## 📈 Analysis Performed

### 1. Funnel Analysis

Analyzed the customer journey across major stages:

```text
Session
   ↓
Product Page
   ↓
Add to Cart
   ↓
Checkout
   ↓
Purchase
```

The analysis identifies the stages with the highest customer drop-off.

### 2. Device Analysis

Compared conversion behavior across:

* Desktop
* Mobile
* Other devices

The analysis identified significant mobile checkout friction.

### 3. Channel Analysis

Compared customer acquisition channels including:

* Organic
* Paid Ads
* Other marketing sources

This helped identify differences in traffic quality and conversion efficiency.

### 4. Time-Based Analysis

Analyzed conversion rates across different hours of the day to identify high-performing periods.

### 5. Cart Abandonment Analysis

Measured:

* Add-to-cart sessions
* Checkout sessions
* Purchase sessions
* Abandonment rate
* Potential revenue recovery

---

## 💡 Business Recommendations

Based on the analysis:

1. **Improve the product detail page experience** to reduce PDP → Cart drop-off.
2. **Optimize the mobile checkout experience** to reduce checkout friction.
3. Review **paid advertising targeting and traffic quality**.
4. Increase campaign focus during **high-conversion evening hours**.
5. Implement **cart recovery campaigns** for abandoned sessions.
6. Use A/B testing to measure the impact of checkout improvements.

---

## 📊 Power BI Dashboard

The Power BI dashboard provides an interactive view of:

* Funnel performance
* Conversion rates
* Cart abandonment
* Device performance
* Channel performance
* Time-based conversion
* GMV recovery opportunities

### GMV Recovery Simulator

The dashboard includes a **GMV Recovery Simulator** using Power BI **DAX What-If Parameters**, allowing users to simulate different cart-recovery scenarios.

---

## 🧠 Key Learnings

During this project, I developed practical experience with:

* Advanced SQL funnel analysis
* CTEs and window functions
* Data cleaning and transformation using Pandas
* Customer conversion analysis
* Cohort and correlation analysis
* Business-oriented data storytelling
* Power BI dashboard development
* DAX measures and What-If Parameters
* Translating analytical findings into business recommendations

---

## 📂 Project Structure

```text
ecommerce-funnel-analysis/
│
├── data/
│   └── Schema & sample datasets
│
├── sql/
│   └── SQL analysis queries
│
├── python/
│   └── Python analysis scripts
│
├── powerbi/
│   └── Power BI dashboard files
│
├── outputs/
│   └── Charts & analysis outputs
│
├── docs/
│   └── SQL & Python documentation
│
├── requirements.txt
└── README.md
```

---

## 🚀 Future Improvements

If this were connected to a real production environment, the project could be extended with:

* 🤖 Logistic Regression for cart-abandonment prediction
* 📊 Automated daily Power BI refresh
* 🧪 A/B testing for mobile checkout improvements
* 🎯 Customer-level abandonment risk scoring
* 🔄 Real-time funnel monitoring
* 🤝 Integration with CRM and marketing platforms

---

## 👨‍💻 Author

### **Pathlavath Arun Naik**

**B.Tech Biotechnology | IIT Madras**

Interested in **Data Analytics, Data Science, AI & Machine Learning**.

### 🔗 Connect With Me

* 📧 Gmail ID: arunnaik6616@gmail.com
* 💻 **GitHub:** [PathlavathArunNaik](https://github.com/PathlavathArunNaik)
* 💼 **LinkedIn:** [Pathlavath Arun Naik](https://www.linkedin.com/in/pathlavath-arun-naik)
