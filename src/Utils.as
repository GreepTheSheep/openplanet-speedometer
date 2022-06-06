namespace Utils
{
    float DegToRad(float degrees) { return degrees * Math::PI / 180.0f; }
}

class CachedImage
{
    string m_url;
    nvg::Texture@ m_texture;

    void DownloadFromURLAsync()
    {
        auto req = Net::HttpRequest();
        req.Method = Net::HttpMethod::Get;
        req.Url = m_url;
        req.Start();
        while (!req.Finished()) {
            yield();
        }
        @m_texture = nvg::LoadTexture(req.Buffer());
        if (m_texture.GetSize().x == 0) {
            @m_texture = null;
        }
    }
}

namespace Images
{
    dictionary g_cachedImages;

    CachedImage@ FindExisting(const string &in url)
    {
        CachedImage@ ret = null;
        g_cachedImages.Get(url, @ret);
        return ret;
    }

    CachedImage@ CachedFromURL(const string &in url)
    {
        // Return existing image if it already exists
        auto existing = FindExisting(url);
        if (existing !is null) {
            return existing;
        }

        // Create a new cached image object and remember it for future reference
        auto ret = CachedImage();
        ret.m_url = url;
        g_cachedImages.Set(url, @ret);

        // Begin downloading
        startnew(CoroutineFunc(ret.DownloadFromURLAsync));
        return ret;
    }
}