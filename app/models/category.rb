class Category < ActiveHash::Base

  self.data = [
    {id: 1, name: "子供同士での交流"},
    {id: 2, name: "子ども食堂"},
    {id: 3, name: "学習支援"},
    {id: 4, name: "多世代交流"},
    {id: 5, name: "その他"}
    ]

    include ActiveHash::Associations
    has_many :tweets
end
