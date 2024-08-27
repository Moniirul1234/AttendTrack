// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Attendance {

    // Struct to represent a student's attendance record
    struct Record {
        bool isPresent;
        uint256 timestamp;
    }

    // Mapping to store attendance records of students
    // studentAddress => date (in timestamp) => Record
    mapping(address => mapping(uint256 => Record)) public attendanceRecords;

    // Event to emit when attendance is recorded
    event AttendanceRecorded(address indexed student, uint256 date, bool isPresent);

    // Function to record attendance
    function recordAttendance(address student, bool isPresent) public {
        uint256 currentDate = block.timestamp / 1 days * 1 days; // Normalize to the start of the day

        // Record attendance
        attendanceRecords[student][currentDate] = Record(isPresent, block.timestamp);

        // Emit event for the recorded attendance
        emit AttendanceRecorded(student, currentDate, isPresent);
    }

    // Function to check attendance for a specific date
    function checkAttendance(address student, uint256 date) public view returns (bool isPresent, uint256 timestamp) {
        Record memory record = attendanceRecords[student][date];
        return (record.isPresent, record.timestamp);
    }
}
