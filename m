Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A87491A0E41
	for <lists+linux-raid@lfdr.de>; Tue,  7 Apr 2020 15:19:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728640AbgDGNTl (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 7 Apr 2020 09:19:41 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35878 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728555AbgDGNTl (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Tue, 7 Apr 2020 09:19:41 -0400
Received: by mail-wr1-f66.google.com with SMTP id k1so3893118wrm.3
        for <linux-raid@vger.kernel.org>; Tue, 07 Apr 2020 06:19:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shenkin.org; s=google;
        h=subject:to:cc:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language;
        bh=TkNWycIVZfsAInBPZgfErxpOheVy0lTdUnzlqSxqhp0=;
        b=Guq+9+ITAHeqiXMxA6yE2SUzomWmVpjqJU3xHKs2gzwxqNewqYAevioL4VQuYrXNP+
         6ztnyvY9KprRNSo4PizU3bTu7SgN7781kc8+zTNREqhZK9QjlJUEbEC0FbDqUHLmNRPM
         IpbGTzCY46SI091IVnfati0rPNoRLM1DtdIDc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language;
        bh=TkNWycIVZfsAInBPZgfErxpOheVy0lTdUnzlqSxqhp0=;
        b=hAdy09hTufN5FFaHMBUDb/2BHYyfSl95Xq1OLM2S4DqqpdFf0z4luXLDOKNHeLgPXq
         5/Yh+HfUFq0MvpZFnQeNRyitX6F8UL/+gpmuQ3Y0975lZHN8j/+huKktZHT3kpgVmL3u
         uMKD8efWtank7eWrdJVhtoiQbckyO1FLoOv7wIlQnRelLTXlefm2oAy1DIE77ykRunPK
         DMtL89VbsCJLfk2FDZcuQsQjX/bhew1QvyOZEcRciysrcNd6lylCSKfxWicK1u0DcHQe
         SMNORJuTJvJsOCo9OBn6wSKLpM35WgKevUr+2ehnZhhfLlLJTOIUCVevZWfb4d1Bk9HC
         WVUA==
X-Gm-Message-State: AGi0PubcaV/mCdAJtqhdGi2uYp6jsEQlnKfGxj31Sk3CRYVPZFB9rrlb
        8Cg5XCbRAc0ucv3eLg1CnFQCiWNY0uQ=
X-Google-Smtp-Source: APiQypIQD3IXl7ycF1+Z4kie90rbZPMg7D7nx4aZB1ZO0uHtJV11pu/hTnCYVMXkJuDZz4laCbKoxw==
X-Received: by 2002:a5d:6588:: with SMTP id q8mr2806098wru.189.1586265575997;
        Tue, 07 Apr 2020 06:19:35 -0700 (PDT)
Received: from [192.168.1.154] (cpc69403-oxfd27-2-0-cust350.4-3.cable.virginm.net. [82.15.57.95])
        by smtp.googlemail.com with ESMTPSA id f5sm21573379wrj.95.2020.04.07.06.19.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Apr 2020 06:19:34 -0700 (PDT)
Subject: Re: Raid-6 cannot reshape
To:     Phil Turmel <philip@turmel.org>,
        Wols Lists <antlists@youngman.org.uk>,
        Roger Heflin <rogerheflin@gmail.com>
Cc:     Linux-RAID <linux-raid@vger.kernel.org>
References: <24a0ef04-46a9-13ee-b8cb-d1a0a5b939fb@shenkin.org>
 <6b9b6d37-6325-6515-f693-0ff3b641a67a@shenkin.org>
 <3135fb29-cfaa-d8ac-264d-fd3110217370@shenkin.org>
 <CAAMCDecyr4R_z3-E8HYwYM4CyQtAY_nBmXdvvMkTgZCcCp7MjQ@mail.gmail.com>
 <5E8B5865.9060107@youngman.org.uk>
 <08d66411-5045-56e1-cbad-7edefa94a363@turmel.org>
 <945332b3-6a47-c2b3-7d1e-70a44f6fd370@shenkin.org>
 <b9bb796e-08cd-e10a-d345-992e5f3abea7@turmel.org>
 <618f5171-785f-09b0-8748-d2549d22c0ab@shenkin.org>
 <38852671-9c5a-3807-0284-41f902e5f81b@turmel.org>
 <44069d88-f838-2b8b-1002-a1fff5502d2d@turmel.org>
From:   Alexander Shenkin <al@shenkin.org>
Autocrypt: addr=al@shenkin.org; prefer-encrypt=mutual; keydata=
 mQENBE1dbG8BCACgMArnyVGKmnRGsdbTeDHSmAIZnuOitigsD1oEiBaAFE7uKsXTMWn1jKeu
 QocRN5l2eBUCrGB+oyTutebbNOxlGU1Y4eTjOsChuSXkYVS3lxqDwIdj1FpuDQw1jFetYtSz
 KEGBFOfXSvdIs7keTeSRbB4GU+nz612k9I1kjYfVKXMMK39PqaemVx3SDqEKoTx++/h4y9Dw
 Vk0QJcB6r5tARr2HMjUdW7QM9jf4RoU+8j+n8zDMKTgvPJF2xYvf/RwrY8EUgFz5cQ1TcIbl
 2vOsycpwLkL8QtuLAW2ylgjqp0u/Em8Eu4bBVG/kjx0Cj4rG845TcCxfmu2Ie/gWGdfrABEB
 AAG0IkFsZXhhbmRlciBTaGVua2luIDxhbEBzaGVua2luLm9yZz6JATgEEwECACIFAk1dbG8C
 GwMGCwkIBwMCBhUIAgkKCwQWAgMBAh4BAheAAAoJENqfFYlMlYrSmy4H+gPMexnwlxFZ/2+G
 zbsJB0EMmlNcMDBqZoelxAMk3wFhhrmu0Z4R+KUJs8AK42RCktk5NLooqMLyOQa8sSI5jq0y
 71y/Ujle4WqJFnea9C0BwxHI7lQAwXFgsDH5/ZG/JrX/3EZkmLvYV/a63QbjnhrVo0zv1+r1
 9tuRekvBWwVKi03e+TyZgU4VbQg5GWGS7Iv4VibbPlficuZ5sSmF4Mn9YgduPi3M0vU/I67o
 q4ETVE3PY8e2o1I9zKL3SLQJE5J1wDPHiuJTpPvPAxlxMABmdpMeLyV5n9XZ2mderGGlfPTV
 fAnBRhvUZA5FdjU56WLWkfx4/gBNKwbRrhvfV8K5AQ0ETV1sbwEIAOt0HMNQhG3RprVQ/R36
 sZB0/CrJzPOwt+Rz1UWOaqzB3c7KkjpvgOTh21G9VGEmjCa+Y0RievO7viu65L7/lD8kxjL7
 3g1t0CyTnXjrlVER/ntV5ZpCAU6t9LEaGJcpunEbtV3RZxqlP6furXl5+AzYR3SgvybbB6Bx
 bUxBrtVbqKbI1UsfB1s5bYR3MCX1IbH+ieovWwtkXYmo2V/1sFgi4ikBQ7TtYnjKSSbl7Bll
 ZbW0ZEmJpCLgqQesLWUiEDLiW7Ce7Bfl1//nwekS/9G7xajS+WFx5XxB2OR7nHcwBWbw70mI
 i+k0DxPFy7+hEngP23UO6iZFzJWVjWFHY9UAEQEAAYkBHwQYAQIACQUCTV1sbwIbDAAKCRDa
 nxWJTJWK0nvJB/wJd6904rR49X9XhLY38FK710w0wMVxSsZIzLZhPFAO3ymv7DUknOUWNVPL
 M3OtVjS1rMIR1VeAjYsp2uxBUOYHHyU4dvC/6Un4jHMU4Y/+WBngG7TvcxczNK3mHzPAXGYM
 PraBN/PyEYt3lbeYdLpPrCOditwD2IFTss+hkUDUTAzzDd5rb1IufGZGUILFnYQI7mHTcbFM
 nYnIbd2xamCtTmAxylCygaBVFAuwMf48N8V9IljdMysvM89+N2aHveDgZUMZPuMBq1N46QsL
 qRYo5UFd8OPrY3xKLMdjaI7jGcjeHG2g83Mu9zT6P8dh0GuZfa51FNdknHpC/5OG5HRr
Message-ID: <61e30bc4-469f-32ed-06e8-d1b4e1fd6740@shenkin.org>
Date:   Tue, 7 Apr 2020 14:19:31 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <44069d88-f838-2b8b-1002-a1fff5502d2d@turmel.org>
Content-Type: multipart/mixed;
 boundary="------------16CB947D7DB33DCE05C3D02F"
Content-Language: en-US
X-Antivirus: Avast (VPS 200406-0, 04/06/2020), Outbound message
X-Antivirus-Status: Clean
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

This is a multi-part message in MIME format.
--------------16CB947D7DB33DCE05C3D02F
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

On 4/7/2020 1:31 PM, Phil Turmel wrote:
> On 4/7/20 8:28 AM, Phil Turmel wrote:
>>>
>>> Thanks Phil,
>>>
>>> The --invalid-backup parameter was necessary to get this up and running.
>>>   It's now up with the 7th disk as a spare.  Shall I run fsck now, or
>>> can
>>> I just try to grow again?
>>>
>>> proposed grow operation:
>>>> mdadm --grow -raid-devices=7 --backup-file=/dev/usb/grow_md127.bak
>>> /dev/md127
>>>> mdadm --stop /dev/md127
>>>> umount /dev/md127 # not sure if this is necessary
>>>> resize2fs /dev/md127
>>
>> An fsck could help, if any blocks did get moved.
>>
>> I would not attempt a grow again until you find out why the previous
>> attempt didn't make progress.  Check if mdmon is running, and/or
>> compile a fresh copy of mdadm from source.  If you don't figure it
>> out, you'll just end up in the same spot again.
> 
> 
> Oh, one more point:  Don't use a backup file.  Let mdadm shift the data
> offsets to get the temporary space needed.  (It'll run faster, too.)
> 
> (I don't see any mdadm --examine reports in the list thread.  Did you do
> them and keep the complete output?)
> 
> Phil
> 

Thanks Phil,

fsck is finding lots and lots of problems.  Figure I'll just run fsck -p
and see what happens... not sure what choice i have...

examine output attached here...

Re re-growing, I was hoping that running on a newer mdadm (4.1) might
fix the problem, and if i still encountered it, perhaps running the
following might unstick it:

echo frozen > /sys/block/md0/md/sync_action
echo reshape > /sys/block/md0/md/sync_action

But, I personally have no idea what happened (really), nor why... :-(

thanks,
allie

--------------16CB947D7DB33DCE05C3D02F
Content-Type: text/plain; charset=UTF-8;
 name="examine.txt"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="examine.txt"

cm9vdEB1YnVudHUtc2VydmVyOi9ob21lL3VidW50dS1zZXJ2ZXIjIG1kYWRtIC0tZXhhbWlu
ZSAvZGV2L3NkW2EtZ10zDQovZGV2L3NkYTM6DQogICAgICAgICAgTWFnaWMgOiBhOTJiNGVm
Yw0KICAgICAgICBWZXJzaW9uIDogMS4yDQogICAgRmVhdHVyZSBNYXAgOiAweDENCiAgICAg
QXJyYXkgVVVJRCA6IGM3MzAzZjYyOmQ4NDhkNDI0OjI2OTU4MWM4OjgzYTA0NWVjDQogICAg
ICAgICAgIE5hbWUgOiB1YnVudHU6Mg0KICBDcmVhdGlvbiBUaW1lIDogU3VuIEZlYiAgNSAy
MzozOTo1OCAyMDE3DQogICAgIFJhaWQgTGV2ZWwgOiByYWlkNg0KICAgUmFpZCBEZXZpY2Vz
IDogNg0KDQogQXZhaWwgRGV2IFNpemUgOiA1ODQwMzc3ODU2ICgyNzg0LjkxIEdpQiAyOTkw
LjI3IEdCKQ0KICAgICBBcnJheSBTaXplIDogMTE2ODA3NTU3MTIgKDExMTM5LjY0IEdpQiAx
MTk2MS4wOSBHQikNCiAgICBEYXRhIE9mZnNldCA6IDI2MjE0NCBzZWN0b3JzDQogICBTdXBl
ciBPZmZzZXQgOiA4IHNlY3RvcnMNCiAgIFVudXNlZCBTcGFjZSA6IGJlZm9yZT0yNjIwNTYg
c2VjdG9ycywgYWZ0ZXI9MCBzZWN0b3JzDQogICAgICAgICAgU3RhdGUgOiBjbGVhbg0KICAg
IERldmljZSBVVUlEIDogMTBiZGJlZDU6Y2I3MGM4YTk6NTY2YzM4NGQ6ZWM0YzkyNmUNCg0K
SW50ZXJuYWwgQml0bWFwIDogOCBzZWN0b3JzIGZyb20gc3VwZXJibG9jaw0KICAgIFVwZGF0
ZSBUaW1lIDogVHVlIEFwciAgNyAxMzoxNDoxMSAyMDIwDQogIEJhZCBCbG9jayBMb2cgOiA1
MTIgZW50cmllcyBhdmFpbGFibGUgYXQgb2Zmc2V0IDcyIHNlY3RvcnMNCiAgICAgICBDaGVj
a3N1bSA6IDMwN2NmZjE1IC0gY29ycmVjdA0KICAgICAgICAgRXZlbnRzIDogMzE2NDk4DQoN
CiAgICAgICAgIExheW91dCA6IGxlZnQtc3ltbWV0cmljDQogICAgIENodW5rIFNpemUgOiA1
MTJLDQoNCiAgIERldmljZSBSb2xlIDogQWN0aXZlIGRldmljZSAwDQogICBBcnJheSBTdGF0
ZSA6IEFBQUFBQSAoJ0EnID09IGFjdGl2ZSwgJy4nID09IG1pc3NpbmcsICdSJyA9PSByZXBs
YWNpbmcpDQovZGV2L3NkYjM6DQogICAgICAgICAgTWFnaWMgOiBhOTJiNGVmYw0KICAgICAg
ICBWZXJzaW9uIDogMS4yDQogICAgRmVhdHVyZSBNYXAgOiAweDENCiAgICAgQXJyYXkgVVVJ
RCA6IGM3MzAzZjYyOmQ4NDhkNDI0OjI2OTU4MWM4OjgzYTA0NWVjDQogICAgICAgICAgIE5h
bWUgOiB1YnVudHU6Mg0KICBDcmVhdGlvbiBUaW1lIDogU3VuIEZlYiAgNSAyMzozOTo1OCAy
MDE3DQogICAgIFJhaWQgTGV2ZWwgOiByYWlkNg0KICAgUmFpZCBEZXZpY2VzIDogNg0KDQog
QXZhaWwgRGV2IFNpemUgOiA1ODQwMzc3ODU2ICgyNzg0LjkxIEdpQiAyOTkwLjI3IEdCKQ0K
ICAgICBBcnJheSBTaXplIDogMTE2ODA3NTU3MTIgKDExMTM5LjY0IEdpQiAxMTk2MS4wOSBH
QikNCiAgICBEYXRhIE9mZnNldCA6IDI2MjE0NCBzZWN0b3JzDQogICBTdXBlciBPZmZzZXQg
OiA4IHNlY3RvcnMNCiAgIFVudXNlZCBTcGFjZSA6IGJlZm9yZT0yNjIwNTYgc2VjdG9ycywg
YWZ0ZXI9MCBzZWN0b3JzDQogICAgICAgICAgU3RhdGUgOiBjbGVhbg0KICAgIERldmljZSBV
VUlEIDogY2Y3MGRhZDU6MGM5ZmY1ZjY6ZWRlNjg5ZjI6Y2NlZTJlYjANCg0KSW50ZXJuYWwg
Qml0bWFwIDogOCBzZWN0b3JzIGZyb20gc3VwZXJibG9jaw0KICAgIFVwZGF0ZSBUaW1lIDog
VHVlIEFwciAgNyAxMzoxNDoxMSAyMDIwDQogIEJhZCBCbG9jayBMb2cgOiA1MTIgZW50cmll
cyBhdmFpbGFibGUgYXQgb2Zmc2V0IDcyIHNlY3RvcnMNCiAgICAgICBDaGVja3N1bSA6IDY0
YjNmZDhiIC0gY29ycmVjdA0KICAgICAgICAgRXZlbnRzIDogMzE2NDk4DQoNCiAgICAgICAg
IExheW91dCA6IGxlZnQtc3ltbWV0cmljDQogICAgIENodW5rIFNpemUgOiA1MTJLDQoNCiAg
IERldmljZSBSb2xlIDogQWN0aXZlIGRldmljZSAxDQogICBBcnJheSBTdGF0ZSA6IEFBQUFB
QSAoJ0EnID09IGFjdGl2ZSwgJy4nID09IG1pc3NpbmcsICdSJyA9PSByZXBsYWNpbmcpDQov
ZGV2L3NkYzM6DQogICAgICAgICAgTWFnaWMgOiBhOTJiNGVmYw0KICAgICAgICBWZXJzaW9u
IDogMS4yDQogICAgRmVhdHVyZSBNYXAgOiAweDENCiAgICAgQXJyYXkgVVVJRCA6IGM3MzAz
ZjYyOmQ4NDhkNDI0OjI2OTU4MWM4OjgzYTA0NWVjDQogICAgICAgICAgIE5hbWUgOiB1YnVu
dHU6Mg0KICBDcmVhdGlvbiBUaW1lIDogU3VuIEZlYiAgNSAyMzozOTo1OCAyMDE3DQogICAg
IFJhaWQgTGV2ZWwgOiByYWlkNg0KICAgUmFpZCBEZXZpY2VzIDogNg0KDQogQXZhaWwgRGV2
IFNpemUgOiA1ODQwMzc3ODU2ICgyNzg0LjkxIEdpQiAyOTkwLjI3IEdCKQ0KICAgICBBcnJh
eSBTaXplIDogMTE2ODA3NTU3MTIgKDExMTM5LjY0IEdpQiAxMTk2MS4wOSBHQikNCiAgICBE
YXRhIE9mZnNldCA6IDI2MjE0NCBzZWN0b3JzDQogICBTdXBlciBPZmZzZXQgOiA4IHNlY3Rv
cnMNCiAgIFVudXNlZCBTcGFjZSA6IGJlZm9yZT0yNjIwNTYgc2VjdG9ycywgYWZ0ZXI9MCBz
ZWN0b3JzDQogICAgICAgICAgU3RhdGUgOiBjbGVhbg0KICAgIERldmljZSBVVUlEIDogZjg4
Mzk5NTI6ZWFiYTJlOWM6YzJjNDAxZDQ6M2UwNTkyYTUNCg0KSW50ZXJuYWwgQml0bWFwIDog
OCBzZWN0b3JzIGZyb20gc3VwZXJibG9jaw0KICAgIFVwZGF0ZSBUaW1lIDogVHVlIEFwciAg
NyAxMzoxNDoxMSAyMDIwDQogIEJhZCBCbG9jayBMb2cgOiA1MTIgZW50cmllcyBhdmFpbGFi
bGUgYXQgb2Zmc2V0IDcyIHNlY3RvcnMNCiAgICAgICBDaGVja3N1bSA6IDVkODcyMGQ2IC0g
Y29ycmVjdA0KICAgICAgICAgRXZlbnRzIDogMzE2NDk4DQoNCiAgICAgICAgIExheW91dCA6
IGxlZnQtc3ltbWV0cmljDQogICAgIENodW5rIFNpemUgOiA1MTJLDQoNCiAgIERldmljZSBS
b2xlIDogQWN0aXZlIGRldmljZSAyDQogICBBcnJheSBTdGF0ZSA6IEFBQUFBQSAoJ0EnID09
IGFjdGl2ZSwgJy4nID09IG1pc3NpbmcsICdSJyA9PSByZXBsYWNpbmcpDQovZGV2L3NkZDM6
DQogICAgICAgICAgTWFnaWMgOiBhOTJiNGVmYw0KICAgICAgICBWZXJzaW9uIDogMS4yDQog
ICAgRmVhdHVyZSBNYXAgOiAweDENCiAgICAgQXJyYXkgVVVJRCA6IGM3MzAzZjYyOmQ4NDhk
NDI0OjI2OTU4MWM4OjgzYTA0NWVjDQogICAgICAgICAgIE5hbWUgOiB1YnVudHU6Mg0KICBD
cmVhdGlvbiBUaW1lIDogU3VuIEZlYiAgNSAyMzozOTo1OCAyMDE3DQogICAgIFJhaWQgTGV2
ZWwgOiByYWlkNg0KICAgUmFpZCBEZXZpY2VzIDogNg0KDQogQXZhaWwgRGV2IFNpemUgOiA1
ODQwMzc3ODU2ICgyNzg0LjkxIEdpQiAyOTkwLjI3IEdCKQ0KICAgICBBcnJheSBTaXplIDog
MTE2ODA3NTU3MTIgKDExMTM5LjY0IEdpQiAxMTk2MS4wOSBHQikNCiAgICBEYXRhIE9mZnNl
dCA6IDI2MjE0NCBzZWN0b3JzDQogICBTdXBlciBPZmZzZXQgOiA4IHNlY3RvcnMNCiAgIFVu
dXNlZCBTcGFjZSA6IGJlZm9yZT0yNjIwNTYgc2VjdG9ycywgYWZ0ZXI9MCBzZWN0b3JzDQog
ICAgICAgICAgU3RhdGUgOiBjbGVhbg0KICAgIERldmljZSBVVUlEIDogODc1YTBkYmQ6OTY1
YTk5ODY6MWI3OGViM2Q6ZTE1ZmVlNTANCg0KSW50ZXJuYWwgQml0bWFwIDogOCBzZWN0b3Jz
IGZyb20gc3VwZXJibG9jaw0KICAgIFVwZGF0ZSBUaW1lIDogVHVlIEFwciAgNyAxMzoxNDox
MSAyMDIwDQogIEJhZCBCbG9jayBMb2cgOiA1MTIgZW50cmllcyBhdmFpbGFibGUgYXQgb2Zm
c2V0IDcyIHNlY3RvcnMNCiAgICAgICBDaGVja3N1bSA6IGM3YWJhNTBmIC0gY29ycmVjdA0K
ICAgICAgICAgRXZlbnRzIDogMzE2NDk4DQoNCiAgICAgICAgIExheW91dCA6IGxlZnQtc3lt
bWV0cmljDQogICAgIENodW5rIFNpemUgOiA1MTJLDQoNCiAgIERldmljZSBSb2xlIDogQWN0
aXZlIGRldmljZSAzDQogICBBcnJheSBTdGF0ZSA6IEFBQUFBQSAoJ0EnID09IGFjdGl2ZSwg
Jy4nID09IG1pc3NpbmcsICdSJyA9PSByZXBsYWNpbmcpDQovZGV2L3NkZTM6DQogICAgICAg
ICAgTWFnaWMgOiBhOTJiNGVmYw0KICAgICAgICBWZXJzaW9uIDogMS4yDQogICAgRmVhdHVy
ZSBNYXAgOiAweDENCiAgICAgQXJyYXkgVVVJRCA6IGM3MzAzZjYyOmQ4NDhkNDI0OjI2OTU4
MWM4OjgzYTA0NWVjDQogICAgICAgICAgIE5hbWUgOiB1YnVudHU6Mg0KICBDcmVhdGlvbiBU
aW1lIDogU3VuIEZlYiAgNSAyMzozOTo1OCAyMDE3DQogICAgIFJhaWQgTGV2ZWwgOiByYWlk
Ng0KICAgUmFpZCBEZXZpY2VzIDogNg0KDQogQXZhaWwgRGV2IFNpemUgOiA1ODQwMzc3ODU2
ICgyNzg0LjkxIEdpQiAyOTkwLjI3IEdCKQ0KICAgICBBcnJheSBTaXplIDogMTE2ODA3NTU3
MTIgKDExMTM5LjY0IEdpQiAxMTk2MS4wOSBHQikNCiAgICBEYXRhIE9mZnNldCA6IDI2MjE0
NCBzZWN0b3JzDQogICBTdXBlciBPZmZzZXQgOiA4IHNlY3RvcnMNCiAgIFVudXNlZCBTcGFj
ZSA6IGJlZm9yZT0yNjIwNTYgc2VjdG9ycywgYWZ0ZXI9MCBzZWN0b3JzDQogICAgICAgICAg
U3RhdGUgOiBjbGVhbg0KICAgIERldmljZSBVVUlEIDogZGMwYmRhOGM6MjQ1N2ZiNGM6Zjg3
YTRiZWM6OGQ1YjU4ZWQNCg0KSW50ZXJuYWwgQml0bWFwIDogOCBzZWN0b3JzIGZyb20gc3Vw
ZXJibG9jaw0KICAgIFVwZGF0ZSBUaW1lIDogVHVlIEFwciAgNyAxMzoxNDoxMSAyMDIwDQog
IEJhZCBCbG9jayBMb2cgOiA1MTIgZW50cmllcyBhdmFpbGFibGUgYXQgb2Zmc2V0IDcyIHNl
Y3RvcnMNCiAgICAgICBDaGVja3N1bSA6IGE4YTQ1MTdlIC0gY29ycmVjdA0KICAgICAgICAg
RXZlbnRzIDogMzE2NDk4DQoNCiAgICAgICAgIExheW91dCA6IGxlZnQtc3ltbWV0cmljDQog
ICAgIENodW5rIFNpemUgOiA1MTJLDQoNCiAgIERldmljZSBSb2xlIDogQWN0aXZlIGRldmlj
ZSA1DQogICBBcnJheSBTdGF0ZSA6IEFBQUFBQSAoJ0EnID09IGFjdGl2ZSwgJy4nID09IG1p
c3NpbmcsICdSJyA9PSByZXBsYWNpbmcpDQovZGV2L3NkZjM6DQogICAgICAgICAgTWFnaWMg
OiBhOTJiNGVmYw0KICAgICAgICBWZXJzaW9uIDogMS4yDQogICAgRmVhdHVyZSBNYXAgOiAw
eDENCiAgICAgQXJyYXkgVVVJRCA6IGM3MzAzZjYyOmQ4NDhkNDI0OjI2OTU4MWM4OjgzYTA0
NWVjDQogICAgICAgICAgIE5hbWUgOiB1YnVudHU6Mg0KICBDcmVhdGlvbiBUaW1lIDogU3Vu
IEZlYiAgNSAyMzozOTo1OCAyMDE3DQogICAgIFJhaWQgTGV2ZWwgOiByYWlkNg0KICAgUmFp
ZCBEZXZpY2VzIDogNg0KDQogQXZhaWwgRGV2IFNpemUgOiA1ODQwMzc3ODU2ICgyNzg0Ljkx
IEdpQiAyOTkwLjI3IEdCKQ0KICAgICBBcnJheSBTaXplIDogMTE2ODA3NTU3MTIgKDExMTM5
LjY0IEdpQiAxMTk2MS4wOSBHQikNCiAgICBEYXRhIE9mZnNldCA6IDI2MjE0NCBzZWN0b3Jz
DQogICBTdXBlciBPZmZzZXQgOiA4IHNlY3RvcnMNCiAgIFVudXNlZCBTcGFjZSA6IGJlZm9y
ZT0yNjIwNTYgc2VjdG9ycywgYWZ0ZXI9MCBzZWN0b3JzDQogICAgICAgICAgU3RhdGUgOiBj
bGVhbg0KICAgIERldmljZSBVVUlEIDogZGM4NDJkYzM6MDljOTEwYzc6YzM1MWMzMDc6ZTIz
ODNkMTMNCg0KSW50ZXJuYWwgQml0bWFwIDogOCBzZWN0b3JzIGZyb20gc3VwZXJibG9jaw0K
ICAgIFVwZGF0ZSBUaW1lIDogVHVlIEFwciAgNyAxMzoxNDoxMSAyMDIwDQogIEJhZCBCbG9j
ayBMb2cgOiA1MTIgZW50cmllcyBhdmFpbGFibGUgYXQgb2Zmc2V0IDcyIHNlY3RvcnMNCiAg
ICAgICBDaGVja3N1bSA6IDlhNjlmMDgzIC0gY29ycmVjdA0KICAgICAgICAgRXZlbnRzIDog
MzE2NDk4DQoNCiAgICAgICAgIExheW91dCA6IGxlZnQtc3ltbWV0cmljDQogICAgIENodW5r
IFNpemUgOiA1MTJLDQoNCiAgIERldmljZSBSb2xlIDogQWN0aXZlIGRldmljZSA0DQogICBB
cnJheSBTdGF0ZSA6IEFBQUFBQSAoJ0EnID09IGFjdGl2ZSwgJy4nID09IG1pc3NpbmcsICdS
JyA9PSByZXBsYWNpbmcpDQovZGV2L3NkZzM6DQogICAgICAgICAgTWFnaWMgOiBhOTJiNGVm
Yw0KICAgICAgICBWZXJzaW9uIDogMS4yDQogICAgRmVhdHVyZSBNYXAgOiAweDENCiAgICAg
QXJyYXkgVVVJRCA6IGM3MzAzZjYyOmQ4NDhkNDI0OjI2OTU4MWM4OjgzYTA0NWVjDQogICAg
ICAgICAgIE5hbWUgOiB1YnVudHU6Mg0KICBDcmVhdGlvbiBUaW1lIDogU3VuIEZlYiAgNSAy
MzozOTo1OCAyMDE3DQogICAgIFJhaWQgTGV2ZWwgOiByYWlkNg0KICAgUmFpZCBEZXZpY2Vz
IDogNg0KDQogQXZhaWwgRGV2IFNpemUgOiA1ODQwMzc3ODU2ICgyNzg0LjkxIEdpQiAyOTkw
LjI3IEdCKQ0KICAgICBBcnJheSBTaXplIDogMTE2ODA3NTU3MTIgKDExMTM5LjY0IEdpQiAx
MTk2MS4wOSBHQikNCiAgICBEYXRhIE9mZnNldCA6IDI2MjE0NCBzZWN0b3JzDQogICBTdXBl
ciBPZmZzZXQgOiA4IHNlY3RvcnMNCiAgIFVudXNlZCBTcGFjZSA6IGJlZm9yZT0yNjIwNTYg
c2VjdG9ycywgYWZ0ZXI9MCBzZWN0b3JzDQogICAgICAgICAgU3RhdGUgOiBjbGVhbg0KICAg
IERldmljZSBVVUlEIDogNjM1ZWY3MWI6ZTRhZGQ5MjU6MzBhZTRmMGE6ZjZiNDY2MTENCg0K
SW50ZXJuYWwgQml0bWFwIDogOCBzZWN0b3JzIGZyb20gc3VwZXJibG9jaw0KICAgIFVwZGF0
ZSBUaW1lIDogVHVlIEFwciAgNyAxMTozNzo0OSAyMDIwDQogIEJhZCBCbG9jayBMb2cgOiA1
MTIgZW50cmllcyBhdmFpbGFibGUgYXQgb2Zmc2V0IDcyIHNlY3RvcnMNCiAgICAgICBDaGVj
a3N1bSA6IDUyYjI3MGQwIC0gY29ycmVjdA0KICAgICAgICAgRXZlbnRzIDogMzE2NDk4DQoN
CiAgICAgICAgIExheW91dCA6IGxlZnQtc3ltbWV0cmljDQogICAgIENodW5rIFNpemUgOiA1
MTJLDQoNCiAgIERldmljZSBSb2xlIDogc3BhcmUNCiAgIEFycmF5IFN0YXRlIDogQUFBQUFB
ICgnQScgPT0gYWN0aXZlLCAnLicgPT0gbWlzc2luZywgJ1InID09IHJlcGxhY2luZykNCg==
--------------16CB947D7DB33DCE05C3D02F--
