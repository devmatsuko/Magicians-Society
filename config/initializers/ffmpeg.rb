# 本番環境時のFFmpegのパス
if Rails.env.production? # 本番環境の場合
  FFMPEG.ffmpeg_binary = '/usr/local/bin/ffmpeg'
end