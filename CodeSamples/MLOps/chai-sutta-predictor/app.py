import streamlit as st
import joblib
import numpy as np

# load model
model = joblib.load("chai_sutta_model.pkl")
st.title("☕ Chai Sutta Predictor")
st.write("Enter details to predict habit")

# user inputs
age = st.slider("Age", 18, 60, 25)
gender = st.selectbox("Gender", ["Male", "Female"])
taunts = st.slider("Number of Taunts per Day", 0, 20, 3)

# convert gender to numeric
if gender == "Male":
    gender_val = 1
else:
    gender_val = 0

# predict button
if st.button("Predict Habit"):
    sample = np.array([[age, gender_val, taunts]])
    prediction = model.predict(sample)
    if prediction[0] == 0:
        result = "Chai Only ☕"
    else:
        result = "Chai + Sutta ☕🚬"
    st.success(f"Prediction: {result}")