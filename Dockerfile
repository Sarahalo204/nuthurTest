# 1. قاعدة Node.js
FROM node:20

# 2. مجلد العمل
WORKDIR /app

# 3. نسخ ملفات Node فقط أولًا
COPY backend/package*.json ./backend/

# 4. تثبيت Node dependencies
RUN cd backend && npm install

# 5. تثبيت Python + أدوات بناء
RUN apt-get update && apt-get install -y python3 python3-pip python3-venv python3-full

# 6. نسخ بقية المشروع
COPY backend ./backend

# 7. إنشاء بيئة افتراضية Python داخل Docker
RUN python3 -m venv /app/venv

# 8. تثبيت requirements داخل venv
RUN /app/venv/bin/pip install --upgrade pip && \
    /app/venv/bin/pip install -r backend/ml/requirements.txt

# 9. إضافة venv إلى PATH
ENV PATH="/app/venv/bin:$PATH"

# 10. فتح البورت
EXPOSE 5000

# 11. تشغيل السيرفر
CMD ["node", "backend/server.js"]
