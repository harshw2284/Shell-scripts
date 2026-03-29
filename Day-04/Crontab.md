# 📅 Crontab Basics — README

## 🧠 What is Crontab?

`crontab` is a Linux utility used to **schedule tasks (jobs)** to run automatically at specific times and intervals.

These tasks are called **cron jobs**.

---

## ⚙️ Crontab Syntax

```
* * * * * command_to_execute
│ │ │ │ │
│ │ │ │ └── Day of Week (0–7) → Sunday = 0 or 7
│ │ │ └──── Month (1–12)
│ │ └────── Day of Month (1–31)
│ └──────── Hour (0–23)
└────────── Minute (0–59)
```

---

## 🔍 Field Explanation

| Field        | Range | Meaning               |
| ------------ | ----- | --------------------- |
| Minute       | 0–59  | When to run (minute)  |
| Hour         | 0–23  | Hour of execution     |
| Day of Month | 1–31  | Date                  |
| Month        | 1–12  | Month                 |
| Day of Week  | 0–7   | Day (0 or 7 = Sunday) |

---

## ⏰ Common Examples

### ✅ Every day at 2 AM

```
0 2 * * * /path/to/script.sh
```

### ✅ Every Sunday at 3 AM

```
0 3 * * 0 /path/to/script.sh
```

### ✅ Every 5 minutes

```
*/5 * * * * /path/to/script.sh
```

### ✅ Every day at midnight

```
0 0 * * * /path/to/script.sh
```

---

## 🚀 How to Apply Crontab

### 1️⃣ Open crontab editor

```
crontab -e
```

---

### 2️⃣ Add your cron job

Example:

```
0 2 * * * /home/user/backup.sh
```

---

### 3️⃣ Save and exit

* Press `ESC`
* Type `:wq` (if using vim)

---

### 4️⃣ Verify cron jobs

```
crontab -l
```

---

## ⚠️ Important Tips

### ✅ Use full paths

Cron does NOT load your normal environment.

```
/usr/bin/python3
/bin/bash
```

---

### ✅ Make script executable

```
chmod +x script.sh
```

---

### ✅ Add logging (for debugging)

```
0 2 * * * /path/to/script.sh >> /path/to/logfile.log 2>&1
```

---

### ✅ Check cron service

```
systemctl status cron
```

---

## ❌ Common Mistakes

* Missing full path to script
* Script not executable
* Wrong time format
* No output/logs → hard to debug

---

## 🎯 Summary

* Crontab automates repetitive tasks
* Uses 5 time fields + command
* Always test your script before scheduling
* Use logging to debug

---

## 💡 Pro Tip

Before running destructive commands (like delete), test with:

```
echo "Test run"
```

---

This README gives you a solid foundation to understand and use crontab effectively.
