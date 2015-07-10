# Node.js LTS team meeting of 06/18/2015

## Participants

* Joao Reis
* Julien Gilli
* Michael Dawson
* Steven Loomis

## Discussions

### Upcoming releases

#### node v0.10.39

Julien: What's left to do: I suggest to revert
https://github.com/joyent/node/pull/25511.

Michael: We have another security release with logjam fixes scheduled for
v0.12, so that's ok with me to move that until next couple of v0.10/v0.12
releases.

Julien: I might have time to start the release process for v0.10.29 today.
Once v0.10 is released, I can move on to releasing v0.12.5.

#### node v0.12.5

Julien: We have [a PR to upgrade npm to
2.11.2](https://github.com/joyent/node/pull/25517). It seems to be a small
change from the current version, so I would advocate for landing that now.

Michael: Playing devil's advocate: would it delay the OpenSSL upgrade? If so,
then we could postpone it to 0.12.6. If the risk is low, and it's fairly quick
to land it, I'm ok with that.

Julien: Breaking changes for v0.12: the OpenSSL upgrade prevents TLS clients
to connect to servers that use DH params with keys that are too short to be
safe.

Michael: Yes, and deferring the change to prevent servers to use shorter keys
until next release.

### Moving this weekly call to the LTS WG call

Julien: We have [a new
doodle](https://github.com/nodejs/LTS/issues/6#issuecomment-112976451) to try
to come up with the best time slot to have these meetings, please fill it out
if you haven't yet.

### Having more than one person managing releases

Julien: having only one person who manage releases is not sustainable, I would
like to have a team of release managers for v0.10.x and v0.12.x releases, and
future LTS releases.

Julien: I've made some good progress on documenting the release process and
improving some of the build scripts and Jenkins jobs to make them usable by
other people than me. Hopefully that will be ready not too long from now.

Julien: In the meantime, I'd like to raise that to the broader LTS group and
see who would be interested in being a release manager.

Steven: I have some experience with releases in the ICU project and other open
source projects, so I can definitely help, even to review and give feedback on
the release process.

Julien: I'll create an issue in nodejs/LTS to gather initial feedback and see
who could be interested.

### Deprecation of shorter keys in DH param server side

Michael: The OpenSSL upgrade to 1.0.1o prevents clients from connecting to
servers using DH parameters that have a key that is too small to be safe. We
should deprecate passing DH params that are unsafe when creating TLS servers
too. I suggested [some changes to do that on
GitHub](https://github.com/joyent/node/issues/25509#issuecomment-112596586),
could you please provide feedback on these changes?

### Transition from v0.12 to next converged LTS release

Michael: Julien started documenting breaking changes between v0.12.x and
what's currently in the converged repository. Julien, is there any way we can help?

Julien: Documenting the changes is really the first step. What I need from you
and other members of the LTS working group is to review this list and give
feedback. Once we're confident that we have an accurate list of breaking
changes, the next step is to reach out to various user communities and
determine what we need to do to make the transition as smooth as possible.

Michael: It seems that there were some productive discussions during Nodeconf
about requirements from users regarding LTS releases.

Julien: Yes, and there are other additional ways we can reach out to the
broader community: leveraging the Node.js Advisory Board, reaching out to
Joyent's Node.js Incubator participants, the broader community on GitHub, etc.
We will need some coordination between a lot of entities within the Node.js
project.

Michael: I would suggest reaching out to nan maintainers to identify V8
breaking changes that would be handled by nan.

Julien: Sounds like a good idea!

Michael: Maybe instead of commenting in an existing issue, Julien could create
new issue on GitHub to get more attention with all details that he
mentioned.

Julien: agreed.

Julien: One other thing that I'd like to use to make the transition even
smoother is release candidates. I had started some work around that a while
ago and unfortunately I haven't had the time to continue working on it. I
think that Rod Vagg did some work around that for io.js and it might be ready
there. Anyway, having release candidates for the next cycle of LTS releases
would probably make things easier.

Michael: Definitely, this is a broader topic for the LTS working group that we
should probably even consider separately.


