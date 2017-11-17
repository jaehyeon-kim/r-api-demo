import json
from locust import HttpLocust, TaskSet, task

class TestTaskSet(TaskSet):

    @task
    def test(self):
        payload = {'n':10, 'wait': 0.5}
        headers = {'content-type': 'application/json'}
        self.client.post('/test', data=json.dumps(payload), headers=headers)
         
class MyLocust(HttpLocust):
    min_wait = 0
    max_wait = 0
    task_set = TestTaskSet
