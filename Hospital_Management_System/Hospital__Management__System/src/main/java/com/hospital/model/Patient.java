package com.hospital.model;

public class Patient {
    private int patientID;
    private String patientName;
    private int age;
    private String gender;
    private String admissionDate;
    private String ailment;
    private String assignedDoctor;

    // Constructors
    public Patient() {}

    public Patient(String patientName, int age, String gender, String admissionDate, String ailment, String assignedDoctor) {
        this.patientName = patientName;
        this.age = age;
        this.gender = gender;
        this.admissionDate = admissionDate;
        this.ailment = ailment;
        this.assignedDoctor = assignedDoctor;
    }

    public Patient(int patientID, String patientName, int age, String gender, String admissionDate, String ailment, String assignedDoctor) {
        this.patientID = patientID;
        this.patientName = patientName;
        this.age = age;
        this.gender = gender;
        this.admissionDate = admissionDate;
        this.ailment = ailment;
        this.assignedDoctor = assignedDoctor;
    }

    
    // Getters and Setters
    public int getPatientID() { return patientID; }
    public void setPatientID(int patientID) { this.patientID = patientID; }

    public String getPatientName() { return patientName; }
    public void setPatientName(String patientName) { this.patientName = patientName; }

    public int getAge() { return age; }
    public void setAge(int age) { this.age = age; }

    public String getGender() { return gender; }
    public void setGender(String gender) { this.gender = gender; }

    public String getAdmissionDate() { return admissionDate; }
    public void setAdmissionDate(String admissionDate) { this.admissionDate = admissionDate; }

    public String getAilment() { return ailment; }
    public void setAilment(String ailment) { this.ailment = ailment; }

    public String getAssignedDoctor() { return assignedDoctor; }
    public void setAssignedDoctor(String assignedDoctor) { this.assignedDoctor = assignedDoctor; }
}
