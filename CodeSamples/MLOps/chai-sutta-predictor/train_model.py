import pandas as pd
from sklearn.model_selection import train_test_split
from sklearn.preprocessing import LabelEncoder
from sklearn.ensemble import RandomForestClassifier
import joblib

# load dataset
data = pd.read_csv("chai_sutta_data.csv")

# encode gender
gender_encoder = LabelEncoder()
data["gender"] = gender_encoder.fit_transform(data["gender"])

# encode target
target_encoder = LabelEncoder()
data["habit"] = target_encoder.fit_transform(data["habit"])

# features and target
X = data[["age","gender","taunts"]]
y = data["habit"]

# split
X_train, X_test, y_train, y_test = train_test_split(
    X, y, test_size=0.2, random_state=42
)

# model
model = RandomForestClassifier()

# train
model.fit(X_train, y_train)

# accuracy
acc = model.score(X_test, y_test)
print("Model Accuracy:", acc)

# save model
joblib.dump(model, "chai_sutta_model.pkl")

print("Model saved as chai_sutta_model.pkl")