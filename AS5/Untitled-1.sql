-- Quesstion 1 --> What are the topics that  reports from CNN
select News_Topic
from News
    join Evidence on Evidence.News_ID = News.News_id
where Evidence.News_Agency = 'CNN'

-- Quesstion 2 --> What are the  news details that occured in United States
select Events.[description]
from Events
    join News on News.News_id = Events.News_id
    join Address on Address.News_ID = News.News_id
where Address.News_country = 'United States'

-- Quesstion 3 --> What are the news topics that report by CNN in 22-02-2021 at Japan
select News.News_Topic
from News
    join Evidence on Evidence.News_id = News.News_id
    join DateTime on DateTime.News_ID = News.News_id
    join Address on Address.News_id = News.News_id
where Address.News_country = 'Japan'AND Evidence.News_Agency = 'CNN'AND DAY(DateTime.News_DateTime) = '22'  