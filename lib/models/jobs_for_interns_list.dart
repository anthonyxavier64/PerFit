import './jobs_for_interns.dart';

class JobsForInternsList {
  List<JobForInterns> _jobsForInternsList = [];

  void addJob(JobForInterns job) {
    _jobsForInternsList.add(job);
    print(_jobsForInternsList.length);
    print('here');
  }

  List<JobForInterns> get jobForInternsList {
    return this._jobsForInternsList;
  }

  String toString() {
    String jobTitles = 'hi';
    for (var i = 0; i < _jobsForInternsList.length; i++) {
      jobTitles += _jobsForInternsList[i].jobTitle + ',';
    }
    return jobTitles;
  }
}
