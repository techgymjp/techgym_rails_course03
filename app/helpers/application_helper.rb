module ApplicationHelper
  def rental_status(data, key)
   if data["status"] == "Cache" || data["status"] == "OK"
     data["libkey"][key] || "書籍が存在しません"
   elsif data["status"] == "Running"
     "取得中"
   else
     "取得エラー"
   end
  end
end
