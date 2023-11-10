#!/usr/bin/python

# class name must be FilterModule
class FilterModule(object):
    '''Email address tools'''

    def filters(self):
        return {
            'email_user': self.email_user,
            'email_domain': self.email_domain,
        }

    def _email_split(self, email_address):
        return email_address.split('@')

    def email_user(self, email_address):
        return self._email_split(email_address)[0]

    def email_domain(self, email_address):
        return self._email_split(email_address)[1]
