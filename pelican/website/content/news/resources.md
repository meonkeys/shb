title: 🗃️ Resources
category: announcement
date: 2024-07-01

Here are some resources I recommend for self-hosters besides what you'll find in the _More Resources_ chapter in the book.

### [selfh.st](https://selfh.st)

selfh.st is a great place to keep up on self-hostable software.
Ethan Sholly ships an excellent email newsletter once a week.

### videos

I'm making short videos to illustrate some concepts from the book.
Here's the first:

#### How to create a test VM for your self-hosting homelab

<video class="howto-video" controls>
  <source src="/video/2024-07-31-make-VM.mp4" />
  <p>Sorry, I am unable to stream this video to you. Please <a href="/video/2024-07-31-make-VM.mp4" download="/video/2024-07-31-make-VM.mp4">download it</a> or try playing it from a different browser or device.</p>
</video>

This demo walks through creating a server VM for use with the book.
You may watch it here or [elsewhere, with ads and other distractions](https://www.youtube.com/watch?v=Qi0uq_VCxiA).

In the installer I use the default auto DHCP networking option to minimize customizations.
I use my LAN router to assign an IP address that doesn't change instead of configuring a static IP address in the server OS (this technique is mentioned in the book under "OS Install").

Take care to download the correct Ubuntu server ISO image for your hardware.
See [this issue](https://github.com/meonkeys/shb/issues/5) if your VM host is a mac and you run into poor performance.

Please forgive my terrible video cropping and editing. I wanted to make sure and leave room for improvement. 😉
