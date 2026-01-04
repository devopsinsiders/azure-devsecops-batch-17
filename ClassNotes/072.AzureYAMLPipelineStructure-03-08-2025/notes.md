# 📘 Class Notes – CI/CD Pipeline Setup & Flow

## 1. **Agent Setup**

* An **agent** must be online for the pipeline to run.
* If not online, it can be started using:

  ```bash
  ./run.cmd
  ```

---

## 2. **Service Connection**

* Service connection must be **configured** and **accessible**.
* Without proper service connection, pipeline execution will fail.

---

## 3. **Pipeline Prerequisites**

1. **Code Repository**

   * The code must be properly available in the repository.
   * Any pipeline execution depends on repo code structure.

2. **Push from Laptop**

   * Developer pushes code changes to the repository.

3. **Pull Request (PR)**

   * Feature branch → Create PR → Merge into main branch after review.

---

## 4. **Feature Branch Workflow**

1. **Automatic Trigger**

   * As soon as code is **pushed to a feature branch**, pipeline should start automatically.

2. **Pipeline Restriction**

   * For **feature branch pipelines**:

     * They should only run **till the “Plan” stage**.
     * Reviewer can merge only if **Plan succeeds**.
     * Pipeline should not proceed beyond Plan in feature branch.

---

## 5. **Requirements for Main Branch**

* Once merged into **main branch**, full pipeline should run (not just Plan).
* YAML pipeline rules ensure different behavior for feature branch vs main branch.

---

## 6. **YAML Pipeline Behavior**

* Even if we write only **steps** in YAML, Azure DevOps automatically creates:

  * A **job**
  * Which runs on an **agent**

---

## 7. **Summary of Workflow**

1. **Feature Branch**

   * Push → Pipeline runs till Plan → If Plan succeeds → PR reviewed → Merge possible.

2. **Main Branch**

   * Merge completed → Full pipeline execution runs → Deployment allowed.

