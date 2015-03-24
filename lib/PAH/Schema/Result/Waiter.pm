=pod

Perpetually Against Humanity, IRC Edition (pah-irc)

Play endless games of Cards Against Humanity on IRC.

https://github.com/grifferz/pah-irc

This code:
    Copyright ©2015 Andy Smith <andy-pah-irc@strugglers.net>

    Artistic license same as Perl.

Get Cards Against Humanity here!
    http://cardsagainsthumanity.com/

    Cards Against Humanity content is distributed under a Creative Commons
    BY-NC-SA 2.0 license. Cards Against Humanity is a trademark of Cards
    Against Humanity LLC.

=cut

package PAH::Schema::Result::Waiter;
use base qw/DBIx::Class::Core/;

__PACKAGE__->table('waiters');

__PACKAGE__->add_columns(

    id => {
        data_type         => 'integer',
        is_auto_increment => 1,
        is_nullable       => 0,
        extra             => { unsigned => 1 },
    },

    # User that is waiting.
    user => {
        data_type   => 'integer',
        is_nullable => 0,
        extra       => { unsigned => 1 },
    },

    # Game that this user is waiting to join.
    game => {
        data_type   => 'integer',
        is_nullable => 0,
        extra       => { unsigned => 1 },
    },

    # unixstamp of when they've been waiting since.
    wait_since => {
        data_type     => 'integer',
        is_nullable   => 0,
        extra         => { unsigned => 1 },
        default_value => 0,
    },
);

__PACKAGE__->set_primary_key('id');

__PACKAGE__->add_unique_constraint(
    'waiter_user_game_idx' => [
        'user',
        'game',
    ]
);

# Relationships.

# A Waiter always has a User.
__PACKAGE__->belongs_to(
    rel_user => 'PAH::Schema::Result::User',
    { 'foreign.id' => 'self.user' }
);

# A Waiter always has a Game.
__PACKAGE__->belongs_to(
    rel_game => 'PAH::Schema::Result::Game',
    { 'foreign.id' => 'self.game' }
);

1;
