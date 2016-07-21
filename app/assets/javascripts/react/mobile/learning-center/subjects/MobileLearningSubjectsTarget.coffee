{ Icon } = antd

module.exports = MobileLearningSubjectsTarget = React.createClass
  render: ->
    <MobileLearningCenterSecondaryLayout 
      title='解决具体问题'
      back_to='/mobile/learning-center/subjects'
    >
      <SearchBox 
        recommend_words={@props.recommend_words}
        results={@props.results}
        search_url={@props.search_url}
        dashboard_url={@props.dashboard_url}
      />
    </MobileLearningCenterSecondaryLayout>


SearchBox = React.createClass
  getInitialState: ->
    current_words: []
    recommend_words: @props.recommend_words
    results: []

  render: ->
    search_bar_data =
      current_words: @state.current_words
      search_bar_input_key_down: @search_bar_input_key_down
      delete_word_form_current_words: @delete_word_form_current_words

    recommend_words_list_data =
      recommend_words: @state.recommend_words
      add_word_to_current_words: @add_word_to_current_words

    <div className="search-box">
      <SearchBar data={search_bar_data}/>
      <RecommendWordsList data={recommend_words_list_data} />
      {
        if @state.results.length == 0 && @state.current_words.length != 0
          <CreateQuestionBox dashboard_url={@props.dashboard_url} />
        else
          <ResultsList results={@state.results} />
      }
    </div>

  search_bar_input_key_down: (e)->
    console.log e.keyCode

    switch e.keyCode
      when 8
        if e.target.value == ""
          @delete_last_current_words()
      when 13, 32 # 空格或回车
        word = e.target.value.replace(new RegExp(" ", 'g'), "")
        if word != ""
          target = e.target
          clear_input = ()->
            target.value = ""
          setTimeout clear_input, 0
          @add_word_to_current_words(word)

  add_word_to_current_words: (word)->
    current_words = @state.current_words
    if current_words.indexOf(word) < 0
      current_words.push(word)
      @setState current_words: current_words
      @post_search()

  delete_word_form_current_words: (word)->
    current_words = @state.current_words
    index = current_words.indexOf(word)
    if index != -1 then current_words.splice(index, 1)
    @setState
      current_words: current_words
    @post_search()

  delete_last_current_words: (e)->
    current_words = @state.current_words
    current_words.pop()
    @setState
      current_words: current_words
    @post_search()

  post_search: ()->
    jQuery.ajax
      url: @props.search_url
      type: 'POST'
      data:
        keywords: @state.current_words
    .done (data)=>
      @setState
        recommend_words: data.recommend_words
        results: data.results

SearchBar = React.createClass
  render: ->
    <div className='search-bar' onClick={@focus_input}>
      {
        for item in @props.data.current_words
          <div className='label' key={item}>
            {item}
            <Icon className='delete' type='cross' onClick={@delete_word(item)} />
          </div>
      }
      <input type='text' placeholder='输入问题描述'' onKeyDown={@props.data.search_bar_input_key_down} />
      <Icon className='search' type='search' />
    </div>

  delete_word: (word)->
    =>
      @props.data.delete_word_form_current_words(word)

  focus_input: (e)->
    console.log e.target
    $div = jQuery(e.target)
    if $div.hasClass('search-bar')
      $div.find('input').focus()

# 推荐词列表
RecommendWordsList = React.createClass
  render: ->
    <div>
      <h3>或者点击以下问题关键词</h3>
      <div className='recommend-words-list'>
      {
        for item in @props.data.recommend_words
          <a className='word' key={item} onClick={@add_word(item)}>
            <Icon type='tag' /> {item}
          </a>
      }
      </div>
    </div>

  add_word: (word)->
    =>
      @props.data.add_word_to_current_words(word)


# 搜索结果列表
ResultsList = React.createClass
  render: ->
    if @props.results.length
      <div>
        <h3>问题匹配结果</h3>
        <div className='questions-results-list shadow-card'>
          {
            for item, idx in @props.results
              <a className='item' key={idx}>
                <Icon type='question-circle-o' />
                <div className='ct'>
                  <div className='title'>{item.title}</div>
                </div>
              </a>
          }
        </div>
      </div>

    else
      <div />

CreateQuestionBox = React.createClass
  getInitialState: ->
    status: "uncreate"

  render: ->
    console.log @props.dashboard_url

    <div className="create-question-box shadow-card">
    {
      switch @state.status
        when "uncreate" then @uncreate_content()
        when "creating" then @creating_content()
        when "created"  then @created_content()
    }
    </div>

  uncreate_content: ->
    <div className="uncreate">
      没有找到相关资料，
      <a className="ui button" onClick={@open_question_form}>按这里记录问题</a>
    </div>

  creating_content: ->
    <div className="creating">
      <textarea placeholder="输入更具体的问题描述" />
      <a className="save ui button" onClick={@create_question}><Icon type='check' /> 保存问题</a>
    </div>

  created_content: ->
    console.log @props.dashboard_url
    <div className="created">
      <span>问题保存完毕，</span>
      <a className="ui button" href={@props.dashboard_url}>按这里返回个人中心</a>
    </div>

  open_question_form: ->
    @setState
      status: "creating"
  create_question: (evt)->
    evt.preventDefault()
    @setState
      status: "created"
