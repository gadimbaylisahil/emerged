function createMessageChannel() {
   App.messages = App.cable.subscriptions.create({
            channel: 'MessagesChannel', chat_id: parseInt($("#message_chat_id").val())
        },
        {
            received: function(data) {
              // $("#messages").removeClass('hidden');
              return $('#messages').append(this.renderMessage(data));
            },
            renderMessage: function(data) {
                return `<div class="row">
                          <div class="col-2 mt-auto mb-auto">
                            <div class="user">
                              <div class="photo">
                                <img class="avatar" src="<%= image_url 'user' %>"/>
                              </div>
                            </div>
                          </div>
                          <div class="col-10">
                            <div class="row">
                              <div class="col-8">
                                <div class="title">
                                    ${data.user}
                                </div>
                              </div>
                              <div class="col-4">
                                <small class="text-muted">
                                    Just now
                                </small>
                              </div>
                            </div>
                            <div class="row">
                              <div class="col-12">
                                <small class="text-muted">
                                  ${data.message}
                                </small>
                              </div>
                            </div>
                          </div>
                        </div>
                        <hr/>
                        `;
            },
        });
    return App.messages;
}